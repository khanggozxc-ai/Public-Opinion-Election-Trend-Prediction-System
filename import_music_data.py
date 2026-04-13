import pandas as pd
import mysql.connector
import os
from dotenv import load_dotenv
from pathlib import Path

# 1. Cấu hình môi trường
env_path = Path(__file__).resolve().parent.parent / ".env"
load_dotenv(env_path)

def import_csv_to_sql(csv_file_path):
    try:
        # KIỂM TRA FILE
        if not os.path.exists(csv_file_path):
            print(f"❌ Lỗi: Không tìm thấy file tại '{csv_file_path}'")
            return

        # BƯỚC 1: ĐỌC FILE KAGGLE
        df = pd.read_csv(csv_file_path)
        
        # LẤY ĐÚNG 15 DÒNG Ở ĐÂY
        df = df.head(15) 
        
        print(f"--- ✅ Đã nhận diện được các cột: {df.columns.tolist()} ---")

        # BƯỚC 2: LÀM SẠCH (Dùng cột 'title' vì file Kaggle không có 'comment_text')
        column_to_clean = 'title' 
        if column_to_clean in df.columns:
            df = df.dropna(subset=[column_to_clean])
        else:
            print(f"❌ Lỗi: File Kaggle không có cột '{column_to_clean}'.")
            return

        # BƯỚC 3: KẾT NỐI DATABASE
        db = mysql.connector.connect(
            host=os.getenv("DB_HOST", "127.0.0.1"),
            user=os.getenv("DB_USER", "root"),
            password=os.getenv("DB_PASSWORD", "170426"),
            database=os.getenv("DB_NAME", "election_db")
        )
        cursor = db.cursor()

        # BƯỚC 4: CHUẨN BỊ DỮ LIỆU
        data_to_import = []
        for index, row in df.iterrows():
            # Gộp Tiêu đề và Mô tả để AI phân tích cho chuẩn
            content = f"{row['title']}. {str(row['description'])[:200]}"
            data_to_import.append((
                'YouTube',          # SourcePlatform
                content,            # RawContent
                row['channel_title'],# AuthorName
                "US"                # Location
            ))

        # BƯỚC 5: NẠP VÀO SQL
        sql = "INSERT INTO SocialData (SourcePlatform, RawContent, AuthorName, Location) VALUES (%s, %s, %s, %s)"
        cursor.executemany(sql, data_to_import)
        db.commit()

        print(f"--- 🚀 THÀNH CÔNG RỒI KHANG ƠI! ---")
        print(f"Đã nạp thành công {cursor.rowcount} dòng từ KAGGLE vào MySQL.")

    except Exception as e:
        print(f"❌ Vẫn còn lỗi này Khang ơi: {e}")
    finally:
        if 'db' in locals() and db.is_connected():
            cursor.close()
            db.close()

# ĐƯỜNG DẪN FILE KAGGLE
kaggle_path = r"C:\Users\HP\.cache\kagglehub\datasets\datasnaek\youtube-new\versions\115\USvideos.csv"
import_csv_to_sql(kaggle_path)