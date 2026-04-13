import mysql.connector
import os
from dotenv import load_dotenv

load_dotenv()

def quick_sentiment(text):
    text = text.lower()
    
    # --- TỪ ĐIỂN SIÊU CẤP ---
    pos_words = ['hay', 'tốt', 'tuyệt', 'vui', 'thích', 'hài lòng', 'đáng xem', 'hữu ích', 'xuất sắc', 'ấn tượng', 'đỉnh', 'quá đỉnh', 'mãi đỉnh', 'cháy', 'ông hoàng', 'love', 'like', 'good', 'best', 'pro', 'xịn', 'xịn xò', 'mượt', 'perfect', 'keo lỳ', 'mãi mận', 'đỉnh nóc', 'kịch trần', 'bay phấp phới', 'u mê', 'hết nước chấm', 'hóng', 'ủng hộ', 'theo dõi', 'sub', 'like cho thớt', 'share', 'cảm ơn']
    neg_words = ['tệ', 'dở', 'chán', 'ghét', 'xấu', 'kém', 'thất vọng', 'phí', 'uổng', 'nhảm', 'rác', 'vớ vẩn', 'tẩy chay', 'phốt', 'lừa', 'xạo', 'điêu', 'bad', 'hate', 'trash', 'fake', 'scam', 'dislike', 'cùi', 'yếu', 'nản', 'ố dề', 'ba chấm', 'hãm', 'lùa gà', 'ngáo', 'ngu', 'dẹp đi', 'nhức đầu', 'huỷ đăng ký', 'unsub', 'report', 'chặn', 'bớt xàm']
    negators = ['không', 'chẳng', 'chưa', 'kém', 'đéo', 'không hề']
    
    pos_score = 0
    neg_score = 0
    words = text.split()

    for i, word in enumerate(words):
        if word in pos_words:
            if i > 0 and words[i-1] in negators: # Vd: "không hay"
                neg_score += 1.5 
            else:
                pos_score += 1
        
        if word in neg_words:
            if i > 0 and words[i-1] in negators: # Vd: "không tệ"
                pos_score += 1
            else:
                neg_score += 1.5

    # --- KẾT LUẬN ---
    if pos_score > neg_score:
        return 'POSITIVE', 0.95
    elif neg_score > pos_score:
        return 'NEGATIVE', 0.90
    else:
        return 'NEUTRAL', 0.85

def analyze_and_save():
    conn = mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )
    cursor = conn.cursor()

    # Chỉ lấy những comment chưa được phân tích (hoặc TRUNCATE trước khi chạy)
    cursor.execute("SELECT comment_id, content FROM social_comments")
    comments = cursor.fetchall()
    print(f"🔍 Đang phân tích {len(comments)} bình luận...")

    results = []
    for comment_id, content in comments:
        label, score = quick_sentiment(content)
        results.append((comment_id, label, score))

    insert_sql = "INSERT IGNORE INTO sentiment_results (comment_id, label, confidence_score) VALUES (%s, %s, %s)"
    cursor.executemany(insert_sql, results)
    
    conn.commit()
    print("✅ Đã cập nhật kết quả phân tích AI!")
    cursor.close()
    conn.close()

if __name__ == "__main__":
    analyze_and_save()