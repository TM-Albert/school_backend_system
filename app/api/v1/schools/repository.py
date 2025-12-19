import uuid

import asyncpg
from models import SchoolCreate, SchoolUpdate
from queries import INSERT_SCHOOL


class SchoolRepository:
    def __init__(self, conn: asyncpg.Connection):
        self.conn = conn

    async def create_school(self, data: SchoolCreate):
        pass

    async def update_school(self, data: SchoolUpdate):
        pass
