from sqlalchemy import create_engine, MetaData, engine
# mysql+pymysql://username:password@localhost:3306/tiket_db
engine = create_engine('mysql+pymysql://root:@localhost:3306/tiket_db')
meta = MetaData()
conn = engine.connect()
ip_public = "http://192.168.0.104"
storage = "/var/www/html/images/"