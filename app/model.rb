require 'pg'

def main
    conn = PG.connect(ENV['DATABASE_URL'])
end

main