from sqlalchemy import create_engine, MetaData, engine
# mysql+pymysql://username:password@localhost:3306/tiket_db
engine = create_engine('mysql+pymysql://root:@localhost:3306/tiket_db')
meta = MetaData()
conn = engine.connect()
ip_public = "http://47.91.56.36"
storage = "/var/www/html/images/"
