from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'Le_Hoan',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'youtube_sentiment_pipeline',
    default_args=default_args,
    description='Tự động cào và phân tích comment YouTube hàng ngày',
    schedule_interval='@daily',
    catchup=False
)

# Chạy container phân tích
run_analysis = BashOperator(
    task_id = 'run_sentiment_analysis',
    # Kiểm tra kỹ dấu nháy đơn ở đầu và cuối chuỗi này
    # Trong file youtube_analysis_dag.py
    # Cập nhật lệnh chạy 3 bước liên hoàn
bash_command = (
    'docker run --rm --env-file /opt/airflow/.env '
    '--network youtube_pipeline_network '
    '-e PYTHONUNBUFFERED=1 youtube-sentiment-app:latest '
    '/bin/bash -c "python scripts/youtube_comments.py && '
    'python scripts/sentiment_analysis.py && '
    'python scripts/transform_star.py"'
),
    dag = dag, # Đảm bảo có dấu phẩy ở cuối dòng trên
)