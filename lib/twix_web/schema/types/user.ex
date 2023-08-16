defmodule TwixWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  @desc "User logic representation"
  object :user do
    field :id, non_null(:id)
    field :nickname, non_null(:string), description: "User's nickname"
    field :age, non_null(:integer), description: "Must be a number equal to or greater than 18"
    field :email, non_null(:string), description: "User's e-mail"
    field :posts, list_of(:post), description: "Posts created by the user"
    field :followers, list_of(:follower)
    field :followings, list_of(:following)
  end

  @desc "Required data to update a user"
  input_object :update_user_input do
    field :id, non_null(:id)
    field :nickname, :string
    field :age, :integer
    field :email, :string
  end

  @desc "Required data to create a new user"
  input_object :create_user_input do
    field :nickname, non_null(:string), description: "User's nickname"
    field :age, non_null(:integer), description: "Must be a number equal to or greater than 18"
    field :email, non_null(:string), description: "User's e-mail"
  end

  @desc "Followed data"
  object :follower do
    field :follower, non_null(:user)
  end

  @desc "Follower data"
  object :following do
    field :following, non_null(:user)
  end

  @desc "Response for adding follower"
  object :add_follower_response do
    field :following_id, non_null(:id)
    field :follower_id, non_null(:id)
  end

  @desc "Required data to create a new follower"
  input_object :add_follower_input do
    field :user_id, non_null(:id)
    field :follower_id, non_null(:id)
  end
end
