require 'pg'
require 'singleton'
require "digest/md5"

class PostgresConnector
  include Singleton
	def initialize()
	    db_parts = ENV['DATABASE_URL'].split(/\/|:|@/)
	    username = db_parts[3]
	    password = db_parts[4]
	    host = db_parts[5]
	    db = db_parts[7]
	    @conn = PGconn.open(:host =>  host, :dbname => db, :user=> username, :password=> password)
	  	@conn.prepare("insert_products", "insert into products (category, effects, discription, prise, current_tax) values ($1, $2, $3, $4, $5)")
	  	@conn.prepare("insert_users", "insert into users (mail, login, password, role) values ($1, $2, $3, $4)")
			@conn.prepare("insert_query", "insert into query (query_text) values ($1)")
			@conn.prepare("insert_order", "insert into payment (value,currency) values ($1,'b')")
			@conn.prepare("update_products", "update products set category = $1, effects = $2, discription = $3, prise = $4, current_tax = $5 where id_product = $6")
			@conn.prepare("update_users", "update users set mail = $1, login = $2, password = $3, role = $4 where id_user = $5")
	end

	def getConnector
		return @conn
	end

	# Create tables
	def createTables
@conn.exec("DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
	id_user serial PRIMARY KEY,
	mail text NOT NULL,
	login text NOT NULL UNIQUE,
	password text NOT NULL,
	role char(1) CHECK (role IN('c','s','a','d')) NOT NULL,
	first_time boolean DEFAULT TRUE,
	other_info text,
	date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS orders CASCADE;
CREATE TABLE orders (
	id_order serial PRIMARY KEY,
	date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
	driver_id integer NOT NULL REFERENCES users ON DELETE CASCADE
);

DROP TABLE IF EXISTS payment CASCADE;
CREATE TABLE payment (
	id_payment serial PRIMARY KEY,
	value integer NOT NULL,
	currency char(1) CHECK (currency IN('l','b'))
);

DROP TABLE IF EXISTS products CASCADE;
CREATE TABLE products (
	id_product serial PRIMARY KEY,
	category integer NOT NULL,
	effects integer NOT NULL,
	discription text NOT NULL,
	prise integer NOT NULL,
	prise_with_tax integer,
	current_tax integer NOT NULL,
	seller_id text
);

DROP TABLE IF EXISTS comments CASCADE;
CREATE TABLE comments (
	id_comment serial PRIMARY KEY,
	info text NOT NULL,
 	product_id integer NOT NULL references products ON DELETE CASCADE,
	user_id integer NOT NULL references users ON DELETE CASCADE,
 	order_id integer NOT NULL references orders ON DELETE CASCADE,
 	payment_id integer NOT NULL references payment ON DELETE CASCADE
);

DROP TABLE IF EXISTS query CASCADE;
CREATE TABLE query (
	id_query serial PRIMARY KEY,
	query_text text NOT NULL,
	date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

DROP function IF EXISTS update_prise() CASCADE;
CREATE FUNCTION update_prise() RETURNS TRIGGER AS 
$X$
BEGIN
	UPDATE products SET prise_with_tax = prise + current_tax;
	RETURN new;
END 
$X$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS add_tax ON products;
CREATE TRIGGER add_tax AFTER UPDATE ON products FOR EACH ROW 
EXECUTE PROCEDURE update_prise();

DROP VIEW IF EXISTS Drivers;
CREATE VIEW Drivers AS
	SELECT *
	FROM users
	WHERE role = 'd';

DROP VIEW IF EXISTS Cheap_products;
CREATE VIEW Cheap_products AS
	SELECT *
	FROM products
	WHERE prise < 10;

DROP VIEW IF EXISTS Expensive_products;
CREATE VIEW Expensive_products AS
	SELECT *
	FROM products
	WHERE prise > 10;

DROP function IF EXISTS update_prise() CASCADE;
CREATE FUNCTION update_prise() RETURNS TRIGGER AS 
$X$
BEGIN
	NEW.prise_with_tax = NEW.prise + NEW.current_tax;
	RETURN NEW;
END 
$X$
LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS uzupelnienie_danych ON products;
CREATE TRIGGER uzupelnienie_danych
BEFORE UPDATE OR INSERT
    ON products
   FOR EACH ROW
EXECUTE PROCEDURE update_prise();

insert into users (mail, login, password, role) values ('tori@robert-i.com', 'admin', \'#{ Digest::MD5.hexdigest('olamakota123')}\', 'a');
");
	end

	def disconnect
    	@conn.close
  	end
end

def createModel
  p = PostgresConnector.instance
	p.createTables
end