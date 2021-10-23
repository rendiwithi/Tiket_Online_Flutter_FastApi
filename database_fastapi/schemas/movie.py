from pydantic import BaseModel

class Movie(BaseModel):
    name:str
    description:str
    imgUrl:str
    rating:int