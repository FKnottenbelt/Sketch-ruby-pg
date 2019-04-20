require 'pg'

begin

# droplet version
# con = PG.connect dbname: 'testdb',
#                   user: 'dbtester',
#                   host: 'localhost',
#                   password: 'dbtesterpsw'

# AWS version. nb create database first
 con = PG.connect dbname: 'testdb',
                  user: 'ec2-user'

  puts con.server_version

  con.exec "DROP TABLE IF EXISTS cars"
  con.exec "CREATE TABLE cars(Id INTEGER PRIMARY KEY,
      Name VARCHAR(20), Price INT)"

  con.exec "INSERT INTO cars VALUES(1,'Audi',52642)"
  con.exec "INSERT INTO cars VALUES(2,'Mercedes',57127)"
  con.exec "INSERT INTO cars VALUES(3,'Skoda',9000)"
  con.exec "INSERT INTO cars VALUES(4,'Volvo',29000)"
  con.exec "INSERT INTO cars VALUES(5,'Bentley',350000)"
  con.exec "INSERT INTO cars VALUES(6,'Citroen',21000)"
  con.exec "INSERT INTO cars VALUES(7,'Hummer',41400)"
  con.exec "INSERT INTO cars VALUES(8,'Volkswagen',21600)"

  rs = con.exec "SELECT * FROM cars LIMIT 5"
  rs.each do |row|
    puts row
  end

  puts
  rs.each do |row|
    puts "#{row['name']} with a price of #{row['price']}"
  end

rescue PG::Error => e

    puts e.message

ensure

    con.close if con

end
