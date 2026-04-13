import os
import mysql.connector
from googleapiclient.discovery import build
from dotenv import load_dotenv
import subprocess

load_dotenv()

def get_youtube_comments(video_id, total_limit=500): # Thêm limit ở đây
    youtube = build('youtube', 'v3', developerKey=os.getenv("YOUTUBE_API_KEY"))
    comments = []
    next_page_token = None
    
    print(f"🚀 Đang thu thập dữ liệu (Mục tiêu: {total_limit} bình luận)...")

    while len(comments) < total_limit:
        # Gọi API lấy tối đa 100 cái mỗi lần
        request = youtube.commentThreads().list(
            part="snippet",
            videoId=video_id,
            maxResults=100,
            pageToken=next_page_token, # Đây là "vé" để sang trang sau
            textFormat="plainText"
        )
        response = request.execute()

        for item in response['items']:
            comment = item['snippet']['topLevelComment']['snippet']
            comments.append({
                'comment_id': item['id'],
                'author_name': comment['authorDisplayName'],
                'content': comment['textDisplay'],
                'published_at': comment['publishedAt']
            })
            # Nếu đã đủ số lượng thì dừng ngay
            if len(comments) >= total_limit:
                break
        
        # Kiểm tra xem còn trang tiếp theo không, nếu không còn thì dừng
        next_page_token = response.get('nextPageToken')
        if not next_page_token:
            break
            
        print(f"📦 Đã lấy được {len(comments)} bình luận...")

    return comments

def save_to_db(video_id, data):
    conn = mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )
    cursor = conn.cursor()
    # Sử dụng INSERT IGNORE để không bị lỗi nếu trùng ID
    sql = "INSERT IGNORE INTO social_comments (comment_id, author_name, content, published_at, video_id) VALUES (%s, %s, %s, %s, %s)"
    val = [(c['comment_id'], c['author_name'], c['content'], c['published_at'], video_id) for c in data]
    
    cursor.executemany(sql, val)
    conn.commit()
    print(f"✅ Tổng cộng: Đã lưu {len(data)} bình luận vào social_comments.")
    cursor.close()
    conn.close()

if __name__ == "__main__":
    target_id = "gfGSGjh77tw" 
    # Bước 1: Cào dữ liệu (Lấy 500 cái)
    data = get_youtube_comments(target_id, total_limit=500)
    save_to_db(target_id, data)
    
    # Bước 2: Tự động gọi Phân tích cảm xúc
    print("🧠 Đang chuyển sang bước Phân tích cảm xúc...")
    subprocess.run(["python", "scripts/sentiment_analysis.py"])
    
    # Bước 3: Tự động chuẩn hóa Star Schema
    print("📊 Đang chuyển sang bước Chuẩn hóa Star Schema...")
    subprocess.run(["python", "scripts/transform_star.py"])