defmodule TwixWeb.Schema.Types.Post do
  @moduledoc false
  use Absinthe.Schema.Notation

  @desc "Post logic representation"
  object :post do
    field :id, non_null(:id), description: "Post ID"
    field :text, non_null(:string), description: "A valid text"
    field :likes, non_null(:integer), description: "A valid like number"
  end

  @desc "Required params to create a new post"
  input_object :create_post_input do
    field :user_id, non_null(:id), description: "User ID"
    field :text, non_null(:string), description: "A valid text"
  end
end
