from sqlalchemy import Table, Column
from sqlalchemy.sql.sqltypes import Integer, String, DateTime
from config.db import meta, engine

schedule = Table('schedule', meta,
                 Column('id', Integer, primary_key=True,
                        autoincrement=True),
                 Column('id_movie', Integer),
                 Column('id_room', Integer),
                 Column('price', Integer),
                 Column('day', String(255)),
                 Column('date_start', DateTime),
                 )

meta.create_all(engine)