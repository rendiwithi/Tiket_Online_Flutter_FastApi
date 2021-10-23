from sqlalchemy import Table, Column, Boolean
from sqlalchemy.sql.schema import ForeignKey, ForeignKeyConstraint
from sqlalchemy.sql.sqltypes import Integer, VARCHAR
from config.db import meta, engine

detail_transaction = Table('detail_transaction', meta,
               Column('id', Integer,nullable=False, primary_key=True, autoincrement=True),
               Column('id_user', Integer),
               Column('id_schedule', Integer),
               Column('id_detail_room', Integer),
               Column('paid', Boolean, nullable=False,default=False),
            )
meta.create_all(engine)