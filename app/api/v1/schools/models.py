from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field


class SchoolCreate(BaseModel):
    id: int
    name: str = Field(max_length=60)
    number: int
    voivodeship_id: int
    city: str = Field(max_length=60)
    street: str = Field(max_length=60)
    post_code: str = Field(max_length=8)
    secretary_phone: str = Field(max_length=15)

    director_id: Optional[int] = None
    profile_id: Optional[int] = None


class SchoolApiResponse(BaseModel):
    id: int
    name: str
    number: int
    voivodeship_id: int
    city: str
    street: str
    post_code: str
    secretary_phone: str
    director_id: Optional[int]
    profile_id: Optional[int]
    creation_date: datetime
    updated_date: Optional[datetime]
    deleted_date: Optional[datetime]


class SchoolUpdate(BaseModel):
    name: Optional[str] = Field(None, max_length=60)
    number: Optional[int] = None
    voivodeship_id: Optional[int] = None
    city: Optional[str] = Field(None, max_length=60)
    street: Optional[str] = Field(None, max_length=60)
    post_code: Optional[str] = None
    secretary_phone: Optional[str] = Field(None, max_length=15)

    director_id: Optional[int] = None
    profile_id: Optional[int] = None
