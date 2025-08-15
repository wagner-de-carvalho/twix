defmodule TwixWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  @desc "User logic representation."
  object :user do
    field :id, non_null(:id)
    field :nickname, non_null(:string), description: "must have at least 3 characters"
    field :age, non_null(:integer), description: "must be equal to or greater than 18"
    field :email, non_null(:string)
    field :posts, list_of(:post)
  end

  input_object :create_user_input do
    field :nickname, non_null(:string)
    field :age, non_null(:integer)
    field :email, non_null(:string)
  end

  input_object :update_user_input do
    field :id, non_null(:id)
    field :nickname, :string
    field :age, :integer
    field :email, :string
  end
end
