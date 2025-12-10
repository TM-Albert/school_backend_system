## DTOS
from pydantic import BaseModel

class StudentCreate_DTO(BaseModel):
    name: str
    age: int


class StudentOut_DTO(BaseModel):
    id: int
    name: str
    surname: str
