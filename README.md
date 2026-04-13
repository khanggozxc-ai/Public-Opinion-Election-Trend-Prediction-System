# YouTube Sentiment Trend Analysis System
Dự án xây dựng hệ thống thu thập, phân tích cảm xúc và dự báo xu hướng dư luận từ bình luận YouTube theo thời gian thực. Hệ thống sử dụng mô hình Star Schema để tối ưu hóa việc truy vấn và trực quan hóa dữ liệu trên Dashboard.

# Tính năng nổi bật
Real-time Crawling: Tự động thu thập 100+ bình luận kèm thời gian thực (published_at) từ YouTube API.

AI Sentiment Analysis: Sử dụng mô hình Machine Learning để phân loại cảm xúc (Tích cực, Tiêu cực, Trung lập).

Data Warehouse (Star Schema): Thiết kế kho dữ liệu chuẩn với các bảng Dimension (Thời gian, Tác giả, Video) và bảng Fact (Cảm xúc) để tăng tốc độ truy vấn.

Interactive Dashboard: Trực quan hóa xu hướng dư luận theo từng giờ và đưa ra nhận định thông minh từ hệ thống.

# Công nghệ sử dụng
Ngôn ngữ: Python (Pandas, MySQL-Connector)

Cơ sở dữ liệu: MySQL 8.0

Containerization: Docker & Docker-Compose

Trực quan hóa: Metabase

Môi trường phát triển: Cursor / VS Code, Git/GitHub

# Kiến trúc hệ thống
Hệ thống vận hành thông qua một Pipeline khép kín:

Crawl: youtube_comments.py lấy dữ liệu thô từ YouTube API.

Analyze: sentiment_analysis.py xử lý ngôn ngữ tự nhiên và gán nhãn cảm xúc.

Transform (ETL): transform_star.py thực hiện chuẩn hóa dữ liệu vào mô hình Star Schema, đảm bảo tính duy nhất (UNIQUE constraint) và đồng bộ thời gian.

# Hướng dẫn cài đặt
Clone repository:

Bash
git clone [Link-GitHub-Của-Khang]
cd [Tên-Thư-Mục-Dự-An]
Cấu hình môi trường:
Tạo file .env và điền thông tin:

Đoạn mã
DB_HOST=db
DB_USER=root
DB_PASSWORD=[Mật-Khẩu-Của-Khang]
DB_NAME=youtube_insight_db
Khởi chạy hệ thống với Docker:

Bash
docker-compose up -d
Chạy Pipeline dữ liệu:

Bash
docker-compose run sentiment_analysis python scripts/youtube_comments.py
# Dashboard Preview
Hệ thống cung cấp các chỉ số quan trọng trên Metabase:

Biểu đồ đường (Trend): Biến động cảm xúc theo mốc giờ thực tế.

Nhận định AI: Hệ thống tự động đưa ra cảnh báo nếu tỷ lệ tiêu cực vượt ngưỡng 60%.

Gauge Chart: Đo lường độ tin cậy của mô hình AI.