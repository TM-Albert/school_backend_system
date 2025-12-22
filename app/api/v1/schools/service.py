from .models import SchoolCreateINPUT, SchoolUpdateINPUT
from .repository import SchoolRepository


class SchoolService:
    def __init__(self, db_connection):
        self.repo = SchoolRepository(db_connection)

    async def create_school(self, data: SchoolCreateINPUT) -> bool:
        school_created: bool = await self.repo.create_school(data)

        return school_created

    async def update_school(self, data: SchoolUpdateINPUT):
        pass

    async def get_school(self, id: int):
        school = await self.repo.get_school_by_id(id)

        return school

    async def get_all_schools(self):
        schools = await self.repo.get_all_schools()

        return schools
