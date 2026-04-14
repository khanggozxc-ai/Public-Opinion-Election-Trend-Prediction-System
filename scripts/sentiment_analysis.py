import mysql.connector
import os
from dotenv import load_dotenv

load_dotenv()

def quick_sentiment(text):
    text = text.lower()
    pos_words = ['hay', 'tốt', 'tuyệt', 'vui', 'thích', 'đỉnh', 'xịn', 'hóng', 'ủng hộ', 'cảm ơn']
    neg_words = ['tệ', 'dở', 'chán', 'ghét', 'nhảm', 'rác', 'vớ vẩn', 'ba chấm', 'ngu']
    
    pos_score = sum(1 for word in pos_words if word in text)
    neg_score = sum(1 for word in neg_words if word in text)

    if pos_score > neg_score: return 'POSITIVE', 0.95
    elif neg_score > pos_score: return 'NEGATIVE', 0.90
    else: return 'NEUTRAL', 0.85

def analyze_and_save():
    conn = mysql.connector.connect(
        host=os.getenv("DB_HOST"), user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"), database=os.getenv("DB_NAME")
    )
    cursor = conn.cursor()

    # Lấy comment_id và content
    cursor.execute("SELECT comment_id, content FROM social_comments")
    comments = cursor.fetchall()
    print(f"🔍 Đang phân tích {len(comments)} bình luận...")

    results = []
    for comment_id, content in comments:
        if content:
            label, score = quick_sentiment(content)
            results.append((comment_id, label, score))

    insert_sql = "REPLACE INTO sentiment_results (comment_id, label, confidence_score) VALUES (%s, %s, %s)"
    cursor.executemany(insert_sql, results)
    
    conn.commit()
    print("✅ Đã cập nhật kết quả phân tích AI!")
    cursor.close()
    conn.close()

if __name__ == "__main__":
    analyze_and_save()