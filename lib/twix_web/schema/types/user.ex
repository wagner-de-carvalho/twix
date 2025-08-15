defmodule TwixWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  @desc "User logic representation."
  object :user do
    field :id, non_null(:id)
    field :nickname, non_null(:string), description: "must have at least 3 characters"
    field :age, non_null(:integer), description: "must be equal to or greater than 18"
    field :email, non_null(:string)
    field :posts, list_of(:post)
    field :followers, list_of(:follower)
    field :followings, list_of(:following)
  end

  object :follower do
    field :follower_id, non_null(:id)
    field :follower, non_null(:user)
  end

  object :following do
    field :following_id, non_null(:id)
    field :following, non_null(:user)
  end

  object :add_follower_response do
    field :following_id, non_null(:id)
    field :follower_id, non_null(:id)
  end

  input_object :add_follower_input do
    field :user_id, non_null(:id)
    field :follower_id, non_null(:id)
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
