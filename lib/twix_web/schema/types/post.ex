defmodule TwixWeb.Schema.Types.Post do
  use Absinthe.Schema.Notation

  @desc "Post logic representation."
  object :post do
    field :id, non_null(:id)
    field :text, non_null(:string), description: "must have at least 1 character and maximum 300"
    field :likes, non_null(:integer)
  end

  input_object :create_post_input do
    field :user_id, non_null(:id), description: "is mandatory"
    field :text, non_null(:string), description: "is mandatory"
  end
end
