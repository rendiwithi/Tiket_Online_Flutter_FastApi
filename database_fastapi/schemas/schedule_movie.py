from pydantic import BaseModel
from datetime import datetime

class ScheduleMoview(BaseModel):
    id_movie:int
    id_room:int
    price:int
    day:str
    date_start:datetime