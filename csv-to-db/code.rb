#YOUR CODE GOES HERE
require "pg"
require "pry"
require "csv"

def db_connection
  begin
    connection = PG.connect(dbname: "ingredients")
    yield(connection)
  ensure
    connection.close
  end
end

# db_connection do |conn|
#   conn.exec('DELETE FROM ingredients;')
# end


CSV.foreach('ingredients.csv', headers: false) do |row|

  db_connection do |conn|
    conn.exec_params("INSERT INTO ingredients (index, ingredient) VALUES ($1, $2)", [row[0], row[1]])
  end

end


db_connection do |conn|
  results = conn.exec('SELECT * FROM ingredients;')
  results.each do |list|
    puts "#{list['index']}. #{list['ingredient']}"
  end
end
