require 'pg'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "brussels_sprouts_recipes")
    yield(connection)
  ensure
    connection.close
  end
end

TITLES = [
  "Roasted Brussels Sprouts",
  "Fresh Brussels Sprouts Soup",
  "Brussels Sprouts with Toasted Breadcrumbs, Parmesan, and Lemon",
  "Cheesy Maple Roasted Brussels Sprouts and Broccoli with Dried Cherries",
  "Hot Cheesy Roasted Brussels Sprout Dip",
  "Pomegranate Roasted Brussels Sprouts with Red Grapes and Farro",
  "Roasted Brussels Sprout and Red Potato Salad",
  "Smoky Buttered Brussels Sprouts",
  "Sweet and Spicy Roasted Brussels Sprouts",
  "Smoky Buttered Brussels Sprouts",
  "Brussels Sprouts and Egg Salad with Hazelnuts"]

  COMMENTS = [
   {11 => "Great Dish!"},
   {1 => "Too Salty!"},
   {2 => "My kids loved them!"},
   {3 => "Easy to make!"},
   {4 => "Meh."},
   {5 => "I've had better."},
   {6 => "Make me puke!"},
   {7 => "Not bad."},
   {8 => "Best brussels ever!"},
   {9 => "Too spicy!"},
   {10 => "The best so far!"},
   {8 => "Great leftovers!"},
   {2 => "I'll definitely make this again!"},
   {4 => "Try it with some bacon!"},
   {1 => "Terrible!"}
  ]

db_connection do |conn|
  TITLES.each do |item|
    conn.exec_params("INSERT INTO recipes (title) VALUES ($1)", [item])
  end

  COMMENTS.each do |hash|
    hash.each do |key, value|
      conn.exec_params("INSERT INTO comments (comment, recipe_id) VALUES ($1, $2)", [value, key])
    end
  end
end
