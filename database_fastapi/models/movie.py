from sqlalchemy import Table, Column
from sqlalchemy.sql.schema import ForeignKey
from sqlalchemy.sql.sqltypes import Integer, VARCHAR
from config.db import meta, engine

movie = Table('movie', meta,
               Column('id', Integer,nullable=False, primary_key=True, autoincrement=True),
               Column('name', VARCHAR(255)),
               Column('description', VARCHAR(255)),
               Column('imgUrl', VARCHAR(255)),
               Column('rating', Integer),
            )
meta.create_all(engine)