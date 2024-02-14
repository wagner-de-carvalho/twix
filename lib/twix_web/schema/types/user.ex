defmodule TwixWeb.Schema.Types.User do
  use Absinthe.Schema.Notation
  alias TwixWeb.Resolvers.User, as: UserResolver

  @desc "User logic representation"
  object :user do
    field :id, non_null(:id), description: "User ID"
    field :nickname, non_null(:string), description: "A valid nickname"
    field :age, non_null(:integer), description: "Must be greater than or equal to 18"
    field :email, non_null(:string), description: "Valid e-mail"

    field :posts, list_of(:post),
      description: "A list of paginated posts. Default values: page = 1, per_page = 10" do
      arg :page, :integer, default_value: 1
      arg :per_page, :integer, default_value: 10
      resolve &UserResolver.get_user_posts/3
    end

    field :followers, list_of(:follower), description: "A list of followers"
    field :followings, list_of(:following), description: "A list of followings"
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

  object :follower do
    field :follower_id, non_null(:id), description: "Follower ID"
    field :follower, non_null(:user), description: "Follower user"
  end

  object :add_follower_response do
    field :follower_id, non_null(:id), description: "Follower ID"
    field :following_id, non_null(:id), description: "Following ID"
  end

  input_object :add_follower_input do
    field :user_id, non_null(:id), description: "Following ID"
    field :follower_id, non_null(:id), description: "Follower ID"
  end

  object :following do
    field :following_id, non_null(:id), description: "Following ID"
    field :following, non_null(:user), description: "Following user"
  end
end
