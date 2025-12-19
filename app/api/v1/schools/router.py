import asyncpg
from fastapi import APIRouter, Depends
from models import SchoolApiResponse, SchoolCreate, SchoolUpdate
from service import SchoolService

from ..db import get_connection

router = APIRouter()


@router.post("/schools")
async def create_school(
    data: SchoolCreate, db_connection: asyncpg.Connection = Depends(get_connection)
):
    school_service = SchoolService(db_connection)

    await school_service.create_school(data)
    pass


@router.put("/schools/{id}")
async def update_school(
    id: int,
    data: SchoolUpdate,
    db_connection: asyncpg.Connection = Depends(get_connection),
):
    pass


@router.get("/schools/{id}", response_model=SchoolApiResponse)
async def get_school(
    id: int, db_connection: asyncpg.Connection = Depends(get_connection)
):
    pass
