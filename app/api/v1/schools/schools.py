import logging
from fastapi import APIRouter, Request, HTTPException, status
from queries import SELECT_ALL_SCHOOLS, SELECT_SCHOOL_BY_ID, INSERT_SCHOOL

router = APIRouter(prefix="/schools")

## SELECT ALL SCHOOLS
@router.get("/", status_code=status.HTTP_200_OK)
async def get_all_schools(request: Request):
    pool = request.app.state.pool

    try:
        async with pool.acquire() as connection:
            query = SELECT_ALL_SCHOOLS
            rows = await connection.fetch(query)

            return {"data": rows}

    except Exception as e:
        print(f"DATABASE ERROR: {str(e)}")

        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, 
            detail="We encountered server error"
        )


## SELECT PARTICULAR SCHOOL
@router.get("/{id}", status_code=status.HTTP_200_OK)
async def get_school(request: Request, id: int):
    pool = request.app.state.pool

    try:
        async with pool.acquire() as connection:
            query = SELECT_SCHOOL_BY_ID
            row = await connection.fetch(query, id)

            return {"data": row}

    except Exception as e:
        print(f"DATABASE ERROR: {str(e)}")

        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, 
            detail="We encountered server error"
        )