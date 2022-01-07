from fastapi import FastAPI, Depends
# from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from routes.user import user
from routes.index import index
from routes.movie import movieR
from routes.detail_transaction import dtR
from routes.schedule_movie import smR
from routes.room import roomR
from routes.detail_room import drR
from routes.data_api import api


app = FastAPI()

app.include_router(index)
app.include_router(user)
app.include_router(movieR)
app.include_router(dtR)
app.include_router(smR)
app.include_router(roomR)
app.include_router(drR)
app.include_router(api)