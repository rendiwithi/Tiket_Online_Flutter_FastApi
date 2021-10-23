from fastapi import APIRouter
from config.db import conn
from models.schedule_movie import schedule as smM
from schemas.schedule_movie import ScheduleMoview as smS


smR = APIRouter()


@smR.get('/schedule_movie/list/')
def fetch_schedule_movie():
    return conn.execute(smM.select()).fetchall()


@smR.post('/schedule_movie/create/')
def create_schedule_movie(sm: smS):
    return conn.execute(smM.insert().values(
        id_movie=sm.id_movie,
        id_room=sm.id_room,
        price=sm.price,
        day=sm.day,
        date_start=sm.date_start,)
    )


@smR.put('/schedule_movie/update/{id}')
def update_schedule_movie(id: int, sm: smS):
    return conn.execute(
        smM.update().values(
            id_movie=sm.id_movie,
            id_room=sm.id_room,
            price=sm.price,
            day=sm.day,
            date_start=sm.date_start,
        )
        .where(smM.c.id == id)
    )


@smR.delete('/schedule_movie/remove/{id}')
def delete_schedule_movie(id: int):
    return conn.execute(
        smM.delete().where(smM.c.id == id)
    )
