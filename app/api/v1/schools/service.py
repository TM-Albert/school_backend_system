from .models import SchoolCreate, SchoolUpdate
from .repository import SchoolRepository


class SchoolService:
    def __init__(self, db_connection):
        self.repo = SchoolRepository(db_connection)

    async def create_school(self, data: SchoolCreate) -> bool:
        school_created: bool = await self.repo.create_school(data)

        return school_created

    async def update_school(self, data: SchoolUpdate):
        pass

    async def get_school(self, id: int):
        school = await self.repo.get_school_by_id(id)

        return school
