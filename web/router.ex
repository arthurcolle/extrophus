defmodule Trophus.Router do
  use Trophus.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end


  pipeline :api do
    plug :accepts, ["json"]
  end



  scope "/", Trophus do
    pipe_through :browser # Use the default browser stack
    get "/auth/callback", UserController, :auth_callback
    get "/instagram", PageController, :instagram
    get "/", PageController, :index
    get "/about", PageController, :about
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    get "/explore", PageController, :explore
    post "/users/:user_id/add_ll", UserController, :add_ll
    resources "/users", UserController do

      resources "/dishes", DishController
    end

    post "/users/customer", UserController, :customer
    
    # see 
    #
    #       https://github.com/opendrops/passport
    #
    # for more on passport
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete

    get "/signup", RegistrationController, :new
    post "/signup", RegistrationController, :create

    # profile stuff
    get "/profile", UserController, :profile
  end
end
