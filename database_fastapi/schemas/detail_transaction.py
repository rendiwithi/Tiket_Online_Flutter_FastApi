from pydantic import BaseModel
from sqlalchemy.sql.expression import false

class DetailTransaction(BaseModel):
    id_user:int
    id_schedule:int
    id_detail_room:int
    paid:bool
