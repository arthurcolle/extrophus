defmodule Trophus.PageController do
  use Trophus.Web, :controller

  plug :action

  def index(conn, _params) do
    IO.puts "Hello users"
    IO.inspect conn.private.plug_session["current_user"]
  	url = Instagram.start
    render conn, "index.html", url: url
  end

  def amazon_callback(conn, _params) do
    render conn, "amazon_callback.html"
  end

  def explore(conn, _params) do

    IO.puts "The current user is..."
    IO.puts conn.private.plug_session["current_user"]

    users = Trophus.Repo.all(Trophus.User) 
    |> Enum.map fn(x) -> Poison.encode! x end

    current_user = users 
    |> Enum.fetch conn.private.plug_session["current_user"]
    
    render conn, "explore.html", users: users
  end

  def thanks(conn, params) do
    IO.inspect params
    render conn, "thanks.html", params: params
  end

  def about(conn, _params) do
    render conn, "about.html"
  end
end
