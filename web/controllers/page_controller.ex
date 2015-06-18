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

  def auth_callback(conn, params) do
  	IO.puts "zebra"
    user = Repo.get(User, conn.private.plug_session["current_user"])
    IO.inspect "The current user is... "
    IO.inspect user
  	# token = Instagram.get_token! %{:code => params["code"]}
  	# user_recent_media = Instagram.user_recent_media(token)
  	# user_data = user_recent_media["data"]
  	# url_list = user_data |> Enum.map fn(x) -> x["images"]["thumbnail"]["url"] end
 	 #  render conn, "instagram.html", images: url_list
  end
end
