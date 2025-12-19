from models import SchoolCreate, SchoolUpdate
from repository import SchoolRepository


class SchoolService:
    def __init__(self, db_connection):
        self.repo = SchoolRepository(db_connection)

    async def create_school(self, data: SchoolCreate):
        pass

    async def update_school(self, data: SchoolUpdate):
        pass
