# Chọn phiên bản 
FROM python:3.11-slim 

# Môi trường làm việc
WORKDIR /app

# Cài đặt công cụ
RUN apt-get update && apt-get install -y \
build-essential \
&& rm -rf /var/lib/apt/lists/*

# copy danh sách các thư viện cần thiết
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy all code
COPY . .

# Tạo thư mục logs để lưu trữ log của ứng dụng
RUN mkdir -p logs

# Chạy ứng dụng khi Container khởi động
CMD ["python", "scripts/youtube_comments.py"]