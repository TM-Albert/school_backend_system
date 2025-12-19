import asyncpg
from db import get_connection
from fastapi import APIRouter, Depends, HTTPException, status

from .models import SchoolApiResponse, SchoolCreate, SchoolUpdate
from .service import SchoolService

router = APIRouter(prefix="/schools")


@router.post("/")
async def create_school(
    data: SchoolCreate,
    db_connection: asyncpg.Connection = Depends(get_connection),
    status_code=status.HTTP_201_CREATED,
):
    school_service = SchoolService(db_connection)

    school_created: bool = await school_service.create_school(data)

    if school_created:
        return {"success": True}

    raise HTTPException(
        status_code=status.HTTP_400_BAD_REQUEST,
        detail={"success": False, "message": ""},
    )


@router.put("/{id}")
async def update_school(
    id: int,
    data: SchoolUpdate,
    db_connection: asyncpg.Connection = Depends(get_connection),
):
    pass


@router.get("/{id}")
async def get_school(
    id: int, db_connection: asyncpg.Connection = Depends(get_connection)
):
    print("RETURN SCHOOL ID")

    school_service = SchoolService(db_connection)

    school = await school_service.get_school(id)

    return {"id": id}
