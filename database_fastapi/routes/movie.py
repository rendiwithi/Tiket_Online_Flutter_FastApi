import os
import shutil
from fastapi import APIRouter, File, UploadFile
from config.db import conn, ip_public, storage
from schemas.movie import Movie
from models.movie import movie

movieR = APIRouter()


@movieR.get('/movie/list/')
def fetch_movie():
    return conn.execute(movie.select()).fetchall()


@movieR.post("/movie/a")
async def image(image: UploadFile = File(...)):
    return {"filename": image.filename}


@movieR.post('/movie/create/')
def create_movie(name: str,
                 description: str,
                 rating: int, image: UploadFile = File(...),):
    i = 0
    isExist = True
    file_name = storage+image.filename.replace(" ", "-")
    imgname = image.filename.replace(" ", "-")
    while isExist:
        if os.path.exists(file_name):
            i += 1
            rep = str(i)+"."
            imgname = image.filename.replace(".", rep)
            file_name = storage+name
        else:
            isExist = False

    with open(file_name, "wb") as buffer:
        shutil.copyfileobj(image.file, buffer)

    conn.execute(movie.insert().values(
        name=name,
        description=description,
        imgUrl=ip_public+"/images/"+imgname,
        rating=rating,
    ))
    return {
        "name": name,
        "description": description,
        "imgUrl": ip_public+"/images/"+imgname,
        "rating": rating,
    }


@movieR.put('/movie/update/{id}')
def update_movie(id: int, Movie: Movie):
    return conn.execute(
        movie.update().values(
            name=Movie.name,
            description=Movie.description,
            imgUrl=Movie.imgUrl,
            rating=Movie.rating,)
        .where(movie.c.id == id)
    )

@movieR.delete('/movie/remove/{id}')
def delete_movie(id: int):
    return conn.execute(
        movie.delete().where(movie.c.id == id)
    )