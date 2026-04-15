from google import genai
import os
import json
from dotenv import load_dotenv

load_dotenv()

# Khởi tạo Client mới
client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))

def test_sentiment():
    sample_comment = "Giá hơi cao nhưng nội dung video rất đầu tư, đáng xem!"
    
    # Chú ý: Thay 'gemini-2.0-flash' bằng tên bạn thấy ở Bước 2
    model_id = 'models/gemini-2.5-flash' 
    
    prompt = f"""
    Phân tích bình luận YouTube: "{sample_comment}"
    Trả về định dạng JSON:
    {{
        "sentiment": "POSITIVE/NEGATIVE/NEUTRAL",
        "aspect": "Giá cả/Chất lượng/Dịch vụ/Chung"
    }}
    Chỉ trả về JSON, không giải thích.
    """
    
    try:
        response = client.models.generate_content(
            model=model_id,
            config={'response_mime_type': 'application/json'}, # Ép ra JSON chuẩn luôn
            contents=prompt
        )
        print(f"Kết quả từ AI: \n{response.text}")
    except Exception as e:
        print(f"❌ Vẫn lỗi: {e}")

if __name__ == "__main__":
    test_sentiment()