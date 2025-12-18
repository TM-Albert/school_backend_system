import uuid

import asyncpg
from queries import GET_USER_BY_ID


class StudentRepository:
    def __init__(self, conn: asyncpg.Connection):
        self.conn = conn

    async def get_by_id(self, user_id: uuid.UUID):
        return await self.conn.fetchrow(GET_USER_BY_ID, user_id)
