defmodule HelloPhoenix.Router do
  use HelloPhoenix.Web, :router
  use Addict.RoutesHelper

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end


  pipeline :api do
    plug :accepts, ["json"]
  end



  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack
    get "/auth/callback", PageController, :auth_callback
    post "/register", PageController, :register
    get "/", PageController, :index
    get "/about", PageController, :about
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    resources "/users", UserController do
      resources "/dishes", DishController
    end
    
    # see 
    #
    #       https://github.com/trenpixster/addict
    #
    # for more on addict
    
    scope "/" do
      addict :routes
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloPhoenix do
  #   pipe_through :api
  # end
end
