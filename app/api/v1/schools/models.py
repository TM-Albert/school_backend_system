from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field, PositiveInt


class SchoolCreateINPUT(BaseModel):
    id: PositiveInt
    name: str = Field(max_length=60)
    number: PositiveInt
    voivodeship_id: int
    city: str = Field(max_length=60)
    street: str = Field(max_length=60)
    post_code: str = Field(max_length=8)
    secretary_phone: str = Field(max_length=15)

    director_id: Optional[PositiveInt] = None
    profile_id: Optional[PositiveInt] = None


class SchoolUpdateINPUT(BaseModel):
    name: Optional[str] = Field(None, max_length=60)
    number: Optional[PositiveInt] = None
    voivodeship_id: Optional[PositiveInt] = None
    city: Optional[str] = Field(None, max_length=60)
    street: Optional[str] = Field(None, max_length=60)
    post_code: Optional[str] = None
    secretary_phone: Optional[str] = Field(None, max_length=15)

    director_id: Optional[PositiveInt] = None
    profile_id: Optional[PositiveInt] = None


class SchoolBaseOUTPUT(BaseModel):
    id: PositiveInt
    name: str
    number: PositiveInt
    voivodeship_id: PositiveInt
    city: str
    street: str
    post_code: str
    secretary_phone: str
    director_id: Optional[PositiveInt]
    profile_id: Optional[PositiveInt]
    creation_date: datetime


class SchoolApiOUTPUT(SchoolBaseOUTPUT):
    pass


class SchoolAdminOUTPUT(SchoolBaseOUTPUT):
    updated_date: Optional[datetime]
    deleted_date: Optional[datetime]
