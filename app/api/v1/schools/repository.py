import asyncpg

from .models import SchoolCreateINPUT, SchoolUpdateINPUT
from .queries import INSERT_SCHOOL, SELECT_ALL_SCHOOLS, SELECT_SCHOOL_BY_ID


class SchoolRepository:
    def __init__(self, db_connection: asyncpg.Connection):
        self.db_connection = db_connection

    async def create_school(self, data: SchoolCreateINPUT) -> bool:
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

    async def update_school(self, data: SchoolUpdateINPUT):
        pass

    async def get_school_by_id(self, id: int):
        school = await self.db_connection.fetchrow(SELECT_SCHOOL_BY_ID, id)

        return school

    async def get_all_schools(self):
        schools = await self.db_connection.fetch(SELECT_ALL_SCHOOLS)

        return schools
