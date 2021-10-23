from sqlalchemy import Table, Column
from sqlalchemy.sql.sqltypes import Integer, String
from config.db import meta, engine

detail_room = Table('detail_room', meta,
                    Column('id', Integer, primary_key=True, autoincrement=True),
                    Column('id_room', Integer),
                    Column('name', String(20)),
                    )
meta.create_all(engine)
