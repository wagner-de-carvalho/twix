defmodule TwixWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  @desc "User logic representation"
  object :user do
    field :id, non_null(:id)
    field :nickname, non_null(:string), description: "User's nickname"
    field :age, non_null(:integer), description: "Must be a number equal to or greater than 18"
    field :email, non_null(:string), description: "User's e-mail"
    field :posts, list_of(:post), description: "Posts created by the user"
  end

  @desc "Required data to create a new user"
  input_object :create_user_input do
    field :nickname, non_null(:string), description: "User's nickname"
    field :age, non_null(:integer), description: "Must be a number equal to or greater than 18"
    field :email, non_null(:string), description: "User's e-mail"
  end

  @desc "Required data to update a user"
  input_object :update_user_input do
    field :id, non_null(:id)
    field :nickname, :string
    field :age, :integer
    field :email, :string
  end
end
