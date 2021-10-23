from fastapi import APIRouter
from config.db import conn
from models.room import room
from schemas.room import Room


roomR = APIRouter()


@roomR.get('/room/list/')
def fetch_users():
    return conn.execute(room.select()).fetchall()


@roomR.post('/room/create/')
def create_users(roomM: Room):
    return conn.execute(room.insert().values(
        name=roomM.name,)
    )


@roomR.put('/room/update/{id}')
def update_users(id: int, roomM: Room):
    return conn.execute(
        room.update().values(
            name=roomM.name,)
        .where(room.c.id == id)
    )


@roomR.delete('/room/remove/{id}')
def delete_users(id: int):
    return conn.execute(
        room.delete().where(room.c.id == id)
    )
