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
    # get "/chat", PageController, :chat
    get "/auth/callback/", UserController, :auth_callback
    get "/get_nearest", SearchController, :get_nearest
    get "/wstest", PageController, :wstest
    get "/unread/:id", UserController, :get_unread
    # get "/cart/:id", CartController, :get_current_order
    post "/add_to_cart", CartController, :add_to_cart

    post "/add_bank_token", UserController, :add_bank_token
    get "/instagram", UserController, :instagram
    get "/", PageController, :index
    get "/about", PageController, :about
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    get "/how-it-works", PageController, :how_it_works
    # get "/explore", PageController, :explore
    get "/explore", PageController, :map
    get "/map", PageController, :map
    get "/distance", PageController, :distance
    post "/users/:user_id/add_ll", UserController, :add_ll
    
    resources "/dishes", DishController
    
    resources "/users", UserController do
      resources "/dishes", DishController
    end

    get "/get_current_order_balance", CartController, :get_current_order_balance
    get "/cart/:user_id", CartController, :show

    post "/update_bio/:user_id", UserController, :update_bio
    post "/update_interests/:user_id", UserController, :update_interests

    resources "/conversations", ConversationController
    # post "/messages/new/:user_id", MessageController, :new
    resources "/messages", MessageController

    get "/dishes/:dish_id/:buyer_id/order", OrderController, :order_dish
    post "/users/customer", UserController, :customer
    post "/get_instagram_images", UserController, :get_images
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
