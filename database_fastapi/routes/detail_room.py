from fastapi import APIRouter
from config.db import conn
from models.detail_room import detail_room as drM
from schemas.detail_room import DetailRoom as drS


drR = APIRouter()


@drR.get('/detail_room/list/')
def fetch_drs():
    return conn.execute(drM.select()).fetchall()


@drR.post('/detail_room/create/')
def create_drs(dr: drS):
    return conn.execute(drM.insert().values(
        id_room=dr.id_room,
        name=dr.name,)
    )


@drR.put('/detail_room/update/{id}')
def update_drs(id: int, dr: drS):
    return conn.execute(
        drM.update().values(
            id_room=dr.id_room,
            name=dr.name,
        )
        .where(drM.c.id == id)
    )


@drR.delete('/detail_room/remove/{id}')
def delete_drs(id: int):
    return conn.execute(
        drM.delete().where(drM.c.id == id)
    )
