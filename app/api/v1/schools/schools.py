from typing import List

import asyncpg
from db import get_connection
from fastapi import APIRouter, Depends, HTTPException, status

from .models import (
    SchoolAdminOUTPUT,
    SchoolApiOUTPUT,
    SchoolCreateINPUT,
    SchoolUpdateINPUT,
)
from .service import SchoolService

router = APIRouter(prefix="/schools")


## CREATE NEW SCHOOL
# @router.post("/", status_code=status.HTTP_201_CREATED)
# async def create_school(
#     data: SchoolCreateINPUT,
#     db_connection: asyncpg.Connection = Depends(get_connection),
# ):
#     school_service = SchoolService(db_connection)

#     school_created: bool = await school_service.create_school(data)

#     if school_created:
#         return {"success": True}

#     raise HTTPException(
#         status_code=status.HTTP_400_BAD_REQUEST,
#         detail={"success": False, "message": ""},
#     )


## SELECT ALL SCHOOLS
@router.get("/", response_model=List[SchoolApiOUTPUT], status_code=status.HTTP_200_OK)
async def get_all_schools(db_connection: asyncpg.Connection = Depends(get_connection)):
    school_service = SchoolService(db_connection)

    schools: List[SchoolApiOUTPUT] = await school_service.get_all_schools()

    return {"data": schools}


## UPDATE SCHOOL
# @router.put("/{id}")
# async def update_school(
#     id: int,
#     data: SchoolUpdateINPUT,
#     db_connection: asyncpg.Connection = Depends(get_connection),
# ):
#     pass


## SELECT PARTICULAR SCHOOL
# @router.get("/{id}")
# async def get_school(
#     id: int, db_connection: asyncpg.Connection = Depends(get_connection)
# ):
#     print("RETURN SCHOOL ID")

#     school_service = SchoolService(db_connection)

#     ## Implement the types and add SchoolApiResponse
#     school = await school_service.get_school(id)

#     return {"id": id}
