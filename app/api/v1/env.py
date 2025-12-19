import os

from dotenv import load_dotenv

load_dotenv()


def get_database_connection_link() -> str | None:
    DB_CONNECTION_LINK = os.getenv("DB_CONNECTION_LINK")

    if DB_CONNECTION_LINK:
        return DB_CONNECTION_LINK

    else:
        print("ENV LOADING ERROR")
        print("DB_CONNECTION_LINK VARIABLE NOT FOUND OR LOADED UNSUCESSFULLY")
        return
