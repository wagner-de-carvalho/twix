defmodule TwixWeb.Schema.Types.Post do
  use Absinthe.Schema.Notation

  @desc "Post logic representation"
  object :post do
    field :id, non_null(:id), description: "Post ID"
    field :text, non_null(:string), description: "Post text"
    field :likes, non_null(:integer), description: "Number of likes"
  end

  @desc "Required data to create a new post"
  input_object :create_post_input do
    field :user_id, non_null(:id), description: "User ID"
    field :text, non_null(:string), description: "Post text"
  end
end
