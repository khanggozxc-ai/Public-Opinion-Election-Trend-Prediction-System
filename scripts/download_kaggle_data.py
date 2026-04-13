import os
import zipfile
from kaggle.api.kaggle_api_extended import KaggleApi

def fetch_data_from_kaggle():
    # 1. Khởi tạo API (Nó sẽ tự tìm mã token Khang đã set ở $env:KAGGLE_API_TOKEN)
    api = KaggleApi()
    api.authenticate()

    # 2. Chọn bộ dữ liệu "ngon" (Ví dụ: YouTube comments)
    # Khang có thể thay tên dataset khác ở đây nhé
    dataset = "advaypattanaik/youtube-video-comments-dataset" 
    path = "./data" # Thư mục chứa dữ liệu

    print(f"--- Đang tải dữ liệu từ {dataset}... ---")
    
    # 3. Tải về và tự động giải nén
    api.dataset_download_files(dataset, path=path, unzip=True)
    
    print(f"--- Xong! File CSV đã nằm gọn trong thư mục {path} rồi nhé Khang! ---")

if __name__ == "__main__":
    fetch_data_from_kaggle()