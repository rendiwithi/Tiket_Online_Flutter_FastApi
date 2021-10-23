from fastapi import APIRouter

index = APIRouter()

@index.get('/')
def fetch_users():
    return {
        "/":"Cek Link for api",
        "/user":{
            "/list/":"get all list user",
            "/create/":"create new list",
            "/update/{id}":"update user by id",
            "/delete/{id}":"delete user by id",
        },
        }
