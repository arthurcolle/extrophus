defmodule HelloPhoenix.User do
  use HelloPhoenix.Web, :model

  schema "users" do
    has_many :dishes, HelloPhoenix.Dish
    field :email, :string
    field :name, :string
    field :username, :string
    field :crypted_password, :string

    # Stripe fields
    field :customer_id, :string
    field :publishable_key, :string
    field :secret_key, :string
    field :connect_id, :string
    timestamps
  end

  @required_fields ~w(email crypted_password)
  @optional_fields ~w(name username customer_id)

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
