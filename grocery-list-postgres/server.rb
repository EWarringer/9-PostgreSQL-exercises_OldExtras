require 'pry'
require 'sinatra'
require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: "grocery_list")
    yield connection
  ensure
    connection.close
  end
end

def groceries_all
  db_connection do |conn|
    sql_query = "SELECT * FROM groceries"
    conn.exec(sql_query)
  end
end

def groceries_push(params)
  unless params["name"].empty?
    db_connection do |conn|
      sql_query = "INSERT INTO groceries (name) VALUES ($1)"
      data = [params["name"]]
      conn.exec_params(sql_query, data)
    end
  end
end

def groceries_grab(id)
  db_connection do |conn|
    sql_query = "SELECT * FROM groceries WHERE id = $1"
    data = [id]
    conn.exec_params(sql_query, data).first
  end
end

def grocery_reviews(id)
  db_connection do |conn|
    sql_query = "SELECT groceries.*, reviews.* FROM groceries
    JOIN reviews ON groceries.id = reviews.grocery_id
    WHERE groceries.id = $1"
    data = [id]
    conn.exec_params(sql_query, data)
  end
end

def review_push(params)
  db_connection do |conn|
    sql_query = "INSERT INTO reviews (body, grocery_id) VALUES ($1, $2)"
    data = [params["body"], params["id"]]
    conn.exec_params(sql_query, data)
  end
end

def grocery_delete(id)
  db_connection do |conn|
    sql_query = "DELETE FROM groceries
    JOIN reviews ON groceries.id = reviews.grocery_id
    WHERE groceries.id = $1"
    data = [id]
    conn.exec_params(sql_query, data)
  end
end

get "/" do
  redirect "/groceries"
end

get "/groceries" do
  groceries = groceries_all
  erb :index, locals: { groceries: groceries }
end

post "/groceries" do
  groceries_push(params)
  redirect "/groceries"
end

get "/groceries/:id" do
  grocery = groceries_grab(params[:id])
  reviews = grocery_reviews(params[:id])
  erb :show, locals: { grocery: grocery, reviews: reviews}
end

post "/groceries/:id/reviews" do
  review_push(params)
  redirect "/groceries/" + params[:id]
end

delete "/groceries/:id" do
  grocery_delete(params)
  redirect "/groceries"
end
