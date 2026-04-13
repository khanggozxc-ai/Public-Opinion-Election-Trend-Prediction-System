import kagglehub

# 1. Tải bản mới nhất của bộ dữ liệu (Dùng ID từ ảnh của Khang)
# Lưu ý: "datasnaek/youtube-new" là bộ dữ liệu trong ảnh bạn vừa chụp
path = kagglehub.dataset_download("datasnaek/youtube-new")

print("--- ✅ Đã tải xong! ---")
print("Dữ liệu của Khang nằm ở thư mục này:", path)

# 2. Liệt kê các file để Khang chọn
import os
print("Trong đó có các file sau:", os.listdir(path))