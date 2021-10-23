from fastapi import APIRouter
from config.db import conn
from sqlalchemy import text

api = APIRouter()


@api.get('/detail/transaction/{id}')
def fetch_users(id: int):
    return conn.execute(text("""
    SELECT s.id as id_schedule, s.price, s.date_start, m.name as movie_title,m.imgUrl, dr.id as id_sheet, dr.name as code_sheet, dt.id as id_transaction,
dt.paid
FROM detail_transaction as dt
JOIN schedule as s on dt.id_schedule = s.id
JOIN movie as m on m.id = s.id_movie
JOIN detail_room as dr on dr.id = dt.id_detail_room
WHERE dt.id_user = """+str(id))).fetchall()


@api.get('/get_sheets/{id}')
def fetch_users(id: int):
    return conn.execute(text("""
    SELECT dr.name,dr.id,(case 
        when dr.id in (
            SELECT dt.id_detail_room from detail_transaction as dt
            WHERE dt.id_schedule = """+str(id)+""" and dt.paid = 1)
        then true
        else false
        end) as sold from detail_room as dr """)).fetchall()


@api.get('/get_schedule/{id}')
def fetch_users(id: int):
    return conn.execute(text("""
    SELECT r.name as room_name, s.id as id_schedule, s.price, s.day, s.date_start from schedule as s
    JOIN room as r on r.id=s.id_room WHERE id_movie = """+str(id))).fetchall()


@api.get('/get_history/')
def fetch_users(id: int):
    return conn.execute(text("""
    SELECT * FROM detail_transaction as dt WHERE dt.id_user = """+str(id))).fetchall()

@api.get('/login/{username}/{password}')
def fetch_users(username:str, password:str):
    return conn.execute(text("""
    SELECT * FROM users as u WHERE u.username = '"""+username+"""' and u.password = '"""+password+"""' LIMIT 1""")).fetchall()
