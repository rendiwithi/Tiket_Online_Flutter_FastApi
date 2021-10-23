from fastapi import APIRouter
from sqlalchemy.sql.expression import false
from config.db import conn
from models.detail_transaction import detail_transaction as dtM
from schemas.detail_transaction import DetailTransaction as dtS


dtR = APIRouter()


@dtR.get('/detail_transaction/list/')
def fetch_dts():
    return conn.execute(dtM.select()).fetchall()


@dtR.post('/detail_transaction/create/{id_user}/{id_schedule}/{id_detail_room}')
def create_dts(id_user: int,
               id_schedule: int,
               id_detail_room: int,):
    conn.execute(dtM.insert().values(
        id_user=id_user,
        id_schedule=id_schedule,
        id_detail_room=id_detail_room,
        paid=0)
    )
    return {"status":200}


@dtR.put('/detail_transaction/update/{id}')
def update_dts(id: int, dt: dtS):
    return conn.execute(
        dtM.update().values(
            id_user=dt.id_user,
            id_schedule=dt.id_schedule,
            id_detail_room=dt.id_detail_room,
            paid=dt.paid
        )
        .where(dtM.c.id == id)
    )


@dtR.delete('/detail_transaction/remove/{id}')
def delete_dts(id: int):
    return conn.execute(
        dtM.delete().where(dtM.c.id == id)
    )
