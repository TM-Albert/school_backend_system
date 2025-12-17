import aiosqlite


class StudentRepository:
    def __init__(self, cursor):
        self._cursor = cursor

    async def get_all(self):
        await self._cursor.execute("SELECT * FROM STUDENTS")

        return await self._cursor.fetchall()
