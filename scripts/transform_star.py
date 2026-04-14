import mysql.connector
import os
from dotenv import load_dotenv

load_dotenv()

def run_etl_transformation():
    conn = mysql.connector.connect(
        host=os.getenv("DB_HOST"), user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"), database=os.getenv("DB_NAME")
    )
    cursor = conn.cursor()
    print("🚀 Đang chuẩn hóa Star Schema...")

    # 1. Dim Authors
    cursor.execute("INSERT IGNORE INTO dim_authors (author_key, author_name) SELECT DISTINCT author_name, author_name FROM social_comments;")
    
    # 2. Dim Videos
    cursor.execute("INSERT IGNORE INTO dim_videos (video_key, video_title) SELECT DISTINCT video_id, video_id FROM social_comments;")

    # 3. Dim Time
    cursor.execute("""
        INSERT IGNORE INTO dim_time (time_key, hour, day, month, year)
        SELECT DISTINCT DATE_FORMAT(published_at, '%Y%m%d%H'), HOUR(published_at), DAY(published_at), MONTH(published_at), YEAR(published_at)
        FROM social_comments;
    """)

    # 4. Fact Sentiments - KHỚP TÊN CỘT THEO DESC CỦA KHANG
    sql_fact = """
    REPLACE INTO fact_sentiments (comment_id, author_key, video_key, time_key, sentiment_label, confidence_score, video_id_original, sentiment_score)
    SELECT sc.comment_id, sc.author_name, sc.video_id, DATE_FORMAT(sc.published_at, '%Y%m%d%H'), sr.label, sr.confidence_score, sc.video_id, sr.confidence_score
    FROM social_comments sc
    JOIN sentiment_results sr ON sc.comment_id = sr.comment_id;
    """
    cursor.execute(sql_fact)
    
    conn.commit()
    print(f"🏁 THÀNH CÔNG: Dữ liệu đã sẵn sàng trên Dashboard!")
    cursor.close()
    conn.close()

if __name__ == "__main__":
    run_etl_transformation()