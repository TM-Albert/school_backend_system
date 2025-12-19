import asyncpg
from models import SchoolCreate, SchoolUpdate
from queries import INSERT_SCHOOL


class SchoolRepository:
    def __init__(self, db_connection: asyncpg.Connection):
        self.db_connection = db_connection

    async def create_school(self, data: SchoolCreate) -> bool:
        created_row = await self.db_connection.fetchrow(
            INSERT_SCHOOL,
            data.id,
            data.name,
            data.number,
            data.voivodeship_id,
            data.city,
            data.street,
            data.post_code,
            data.secretary_phone,
            data.director_id,
            data.profile_id,
        )

        if not created_row:
            return False

        return True

    async def update_school(self, data: SchoolUpdate):
        pass
