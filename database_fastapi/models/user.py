from sqlalchemy import Table, Column
from sqlalchemy.sql.sqltypes import Integer, String
from config.db import meta, engine

users = Table('users',meta,
Column('id', Integer, primary_key=True,autoincrement=True),
Column('name', String(255), nullable=False),
Column('username', String(255), nullable=False),
Column('password', String(255), nullable=False),
)

meta.create_all(engine)