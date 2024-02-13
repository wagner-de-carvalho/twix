defmodule TwixWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  @desc "User logic representation"
  object :user do
    field :id, non_null(:id), description: "User ID"
    field :nickname, non_null(:string), description: "A valid nickname"
    field :age, non_null(:integer), description: "Must be greater than or equal to 18"
    field :email, non_null(:string), description: "Valid e-mail"
    field :posts, list_of(:post), description: "A list of posts"
  end

  @desc "Required params to create a new user"
  input_object :create_user_input do
    field :nickname, non_null(:string), description: "A valid nickname"
    field :age, non_null(:integer), description: "Must be greater than or equal to 18"
    field :email, non_null(:string), description: "Valid e-mail"
  end

  @desc "Required params to update an user"
  input_object :update_user_input do
    field :id, non_null(:id), description: "User ID"
    field :nickname, :string, description: "A valid nickname"
    field :age, :integer, description: "Must be greater than or equal to 18"
    field :email, :string, description: "Valid e-mail"
  end
end
