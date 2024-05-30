import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY')
    DATABASE_URL = os.getenv('DATABASE_URL')
    FOOTBALL_DATA_API_KEY = os.getenv('FOOTBALL_DATA_API_KEY')
