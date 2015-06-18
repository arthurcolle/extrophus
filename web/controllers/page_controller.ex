defmodule Trophus.PageController do
  use Trophus.Web, :controller

  plug :action

  def index(conn, _params) do
    IO.puts "Hello users"
    IO.inspect conn.private.plug_session["current_user"]
  	url = Instagram.start
    
    render conn, "index.html", url: url
  end

  def explore(conn, _params) do
    render conn, "explore.html"
  end

  def thanks(conn, params) do
    IO.inspect params
    render conn, "thanks.html", params: params
  end

  def about(conn, _params) do
    render conn, "about.html"
  end
end
