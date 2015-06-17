defmodule Trophus.User do
  use Trophus.Web, :model

  schema "users" do
    has_many :dishes, Trophus.Dish
    field :email, :string
    field :name, :string
    field :username, :string
    field :crypted_password, :string
    field :phone_number, :string
    field :home, :string
    
    field :address_line_1
    field :address_line_2
    field :address_state
    field :address_city
    field :address_zip

    # Stripe fields
    field :customer_id, :string
    field :publishable_key, :string
    field :secret_key, :string
    field :connect_id, :string
    timestamps
  end

  @required_fields ~w(email crypted_password)
  @optional_fields ~w(name username home phone_number address_line_1 address_line_2 address_state address_city address_zip customer_id publishable_key secret_key connect_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
