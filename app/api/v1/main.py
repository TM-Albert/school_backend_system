from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from fastapi import Depends

DATABASE_URL = ""

Base = declarative_base()

engine = create_engine(
    DATABASE_URL,
    pool_pre_ping=True
)