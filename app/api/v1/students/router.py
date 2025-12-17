from fastapi import APIRouter, Depends

from ..db import get_db
from ..students.repository import StudentRepository

router = APIRouter()


@router.get("/")
async def get_all_students(db_cursor=Depends(get_db)):
    repo: StudentRepository = StudentRepository(db_cursor)

    students = await repo.get_all()

    ## Wartstwa obróbki danych chyba że nie trzeba i z bazy danych od razu zapytaniem się zwróci to co potrzebne jest

    return students
