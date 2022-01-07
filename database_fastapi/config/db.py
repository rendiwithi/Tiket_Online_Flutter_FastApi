from sqlalchemy import create_engine, MetaData, engine
# mysql+pymysql://username:password@localhost:3306/tiket_db
engine = create_engine('mysql+pymysql://root:@localhost:3306/tiket_db')
meta = MetaData()
conn = engine.connect()
ip_public = "https://krisnawahyu.my.id"
storage = "/var/www/html/images/"
