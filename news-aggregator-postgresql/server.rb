# Completed by Erik Warringer & Jacob Latter
require 'pg'
require 'pry'
require 'sinatra'
require 'csv'

POST_FILE = "post.csv"

def db_connection
  begin
    connection = PG.connect(dbname: "news_aggregator_development")
    yield(connection)
  ensure
    connection.close
  end
end


get '/articles' do
  db_connection do |conn|
    results = conn.exec('SELECT * FROM articles')
    erb :index, locals: { results: results }
  end
end


get '/articles/new' do
  erb :post
end


post '/posts' do
  db_connection do |conn|
    conn.exec_params("INSERT INTO articles (title, url, description) VALUES ($1, $2, $3)", [params["title"], params["url"], params["description"]])
  end
  redirect '/articles'
end
