require 'pg'
require 'singleton'

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
	  	@conn.prepare("insert_users", "insert into users (mail, login, password, role, data) values ($1, $2, $3, $4, $5)")
			@conn.prepare("insert_query", "insert into query (query_text) values ($1)")
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
			data text
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
			current_tax integer NOT NULL
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
		);");
	end

	def disconnect
    	@conn.close
  	end
end

def createModel
  p = PostgresConnector.instance
	p.createTables
end