require 'pg'

def main
    db_parts = ENV['DATABASE_URL'].split(/\/|:|@/)
    username = db_parts[3]
    password = db_parts[4]
    host = db_parts[5]
    db = db_parts[7]
    conn = PGconn.open(:host =>  host, :dbname => db, :user=> username, :password=> password)
end

main