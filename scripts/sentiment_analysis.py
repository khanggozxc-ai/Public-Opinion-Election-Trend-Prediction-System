import os
import json
import mysql.connector
from google import genai 
from dotenv import load_dotenv

# 1. Tải biến môi trường
load_dotenv()

# 2. Khởi tạo Database & AI Client
# Lưu ý: DB_HOST phải là 'localhost' nếu Khang chạy từ Terminal Windows
db = mysql.connector.connect(
    host=os.getenv("DB_HOST", "localhost"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    database=os.getenv("DB_NAME")
)
cursor = db.cursor()
client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))

def analyze_sentiment_and_aspect(text):
    """Hàm phân tích của Khang - Giữ nguyên logic pro"""
    model_id = 'gemini-2.5-flash'
    prompt = f"""
    Bạn là chuyên gia phân tích dữ liệu. Hãy phân tích bình luận sau: "{text}"
    Trả về kết quả duy nhất dưới định dạng JSON:
    {{
        "sentiment": "POSITIVE/NEGATIVE/NEUTRAL",
        "aspect": "Giá cả/Chất lượng/Dịch vụ/Chung"
    }}
    Lưu ý: Chỉ trả về JSON, không giải thích gì thêm.
    """
    try:
        response = client.models.generate_content(
            model=model_id,
            config={'response_mime_type': 'application/json', 'temperature': 0.1},
            contents=prompt
        )
        return json.loads(response.text)
    except Exception as e:
        print(f"Lỗi AI: {e}")
        return {"sentiment": "NEUTRAL", "aspect": "Chung"}

def run_pipeline():
    print("🚀 --- ĐANG KHỞI CHẠY TIẾN TRÌNH PHÂN TÍCH AI (BƯỚC 3 & 4) ---")
    
    # Lấy các bình luận chưa được phân tích (Logic DE chuẩn)
    query_fetch = """
        SELECT comment_id, content 
        FROM social_comments 
        WHERE comment_id NOT IN (SELECT comment_id FROM sentiment_results)
    """
    cursor.execute(query_fetch)
    rows = cursor.fetchall()
    
    if not rows:
        print("💡 Không có bình luận mới. Khang hãy chạy 'youtube_comments.py' trước nhé!")
        return

    print(f"📊 Tìm thấy {len(rows)} bình luận cần xử lý. Bắt đầu gọi Gemini...")

    for c_id, content in rows:
        # Gọi hàm phân tích của Khang
        result = analyze_sentiment_and_aspect(content)
        
        label = result.get('sentiment', 'NEUTRAL')
        aspect = result.get('aspect', 'Chung')
        
        # Lưu kết quả vào bảng Analytics
        sql_insert = "INSERT INTO sentiment_results (comment_id, label, aspect) VALUES (%s, %s, %s)"
        cursor.execute(sql_insert, (c_id, label, aspect))
        
        print(f"✅ Đã phân tích ID {c_id[:5]}... | [{label}] | Khía cạnh: {aspect}")
        
    db.commit() # Quan trọng: Lưu thay đổi vào DB
    print("🎯 TẤT CẢ DỮ LIỆU ĐÃ ĐƯỢC AI XỬ LÝ XONG!")

# ĐÂY LÀ DÒNG LỆNH KÍCH HOẠT QUY TRÌNH
if __name__ == "__main__":
    run_pipeline()