CREATE TABLE IF NOT EXISTS social_comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    comment_id VARCHAR(255) UNIQUE,
    author_name VARCHAR(255),
    content TEXT,
    comment_text TEXT,
    published_at DATETIME,
    video_id VARCHAR(50),
    target_id VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS sentiment_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    comment_id VARCHAR(255) UNIQUE,
    label VARCHAR(50),
    confidence_score FLOAT
);

CREATE TABLE IF NOT EXISTS fact_sentiments (
    fact_id INT AUTO_INCREMENT PRIMARY KEY,
    comment_id VARCHAR(255) UNIQUE,
    author_key VARCHAR(255),
    video_key VARCHAR(50),
    time_key VARCHAR(20),
    sentiment_label VARCHAR(50),
    confidence_score FLOAT,
    video_id_original VARCHAR(50),
    sentiment_score FLOAT
);

CREATE TABLE IF NOT EXISTS dim_authors (author_key VARCHAR(255) PRIMARY KEY, author_name VARCHAR(255));
CREATE TABLE IF NOT EXISTS dim_videos (video_key VARCHAR(50) PRIMARY KEY, video_title TEXT);
CREATE TABLE IF NOT EXISTS dim_time (time_key VARCHAR(20) PRIMARY KEY, hour INT, day INT, month INT, year INT);
