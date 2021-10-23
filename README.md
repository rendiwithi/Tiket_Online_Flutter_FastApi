# Tiket_Online_Flutter_FastApi
Cara Run Program Bioskop+API Run Code Pertama

NB:	- setelah sql query phpmyadmin silahkan matikan server lalu run lagi agar data terupdate
	- setelah run fastapi bisa buka di http://localhost:8000/docs => ini rekomend kalau mau ngubah data sql

# PERSIAPAN

# PYTHON
Mungkin Butuh Sesuatu karena error
pip install fastapi
pip install uvicorn
pip install pydantic
pip install SQLAlchemy
pip install aiofiles
pip install python-multipart
curl -fsSL https://get.deta.dev/cli.sh | sh

# FASTAPI
activate env : source env/bin/activate
Cara run server via CLI
	uvicorn --host 0.0.0.0 main:app --reload
Lalu Buka database_fastapi/lib/model/db.py
atur konfigurasi
engine = create_engine('mysql+pymysql://duck:@localhost:3306/tiket_db')		//duck = user anda sebelum @ masukkan password user
ip_public = "http://192.168.0.104"						//masukkan ip server(Laptop) anda
storage = "/var/www/html/images/"						//Buat folder images dulu agar rapi

# FLUTTER
buka tiket_bioskop_online/lib/constant/api.dart
atur konfigurasi
String ip = "http://192.168.0.104:8000";	//sesuaikan dengan ip anda
lalu run code
	flutter clean
	flutter pub get 

terus run aja seperti run flutter
	
# GASSSKEUUNNNNN

1. tambah movie
2. tambah user
3. tambah room
4. tambah sheet rekomendasi 30 sheet/detail_room
	INSERT INTO `detail_room` (`id`, `id_room`, `name`) VALUES 
	(NULL, '1', 'A1'),
	(NULL, '1', 'A2'),
	(NULL, '1', 'A3'),
	(NULL, '1', 'A4'),
	(NULL, '1', 'A5'),
	(NULL, '1', 'A6'),
	(NULL, '1', 'A7'),
	(NULL, '1', 'A8'),
	(NULL, '1', 'A9'),
	(NULL, '1', 'A10'),
	(NULL, '1', 'A11'),
	(NULL, '1', 'A12'),
	(NULL, '1', 'A13'),
	(NULL, '1', 'A14'),
	(NULL, '1', 'A15'),
	(NULL, '1', 'A16'),
	(NULL, '1', 'A17'),
	(NULL, '1', 'A18'),
	(NULL, '1', 'A19'),
	(NULL, '1', 'A20'),
	(NULL, '1', 'A21'),
	(NULL, '1', 'A22'),
	(NULL, '1', 'A23'),
	(NULL, '1', 'A24'),
	(NULL, '1', 'A25'),
	(NULL, '1', 'A26'),
	(NULL, '1', 'A27'),
	(NULL, '1', 'A28'),
	(NULL, '1', 'A29'),
	(NULL, '1', 'A30');
5. tambah schedule
5.5 bisa stop server terus run lagi
6. coba pesan tiket lalu tambahkan
7. Selesai.
7.1 ekhem mungkin bisa tag ig ku @rendiwithi
