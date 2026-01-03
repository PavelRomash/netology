from flask import Flask
import pymysql
import os

app = Flask(__name__)

DB_HOST = os.getenv("DB_HOST")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")
DB_SSL_CA = os.getenv("DB_SSL_CA")

@app.route("/")
def index():
    try:
        conn = pymysql.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME,
            connect_timeout=5,
            ssl={"ca": DB_SSL_CA}
        )
        conn.close()
        return "Flask app is running and connected to MySQL"
    except Exception as e:
        return f"Database connection error: {e}", 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
