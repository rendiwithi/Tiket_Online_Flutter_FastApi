from pydantic import BaseModel

class DetailRoom(BaseModel):
    id_room:int
    name:str