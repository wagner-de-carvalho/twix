defmodule TwixWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:id)
    field :nickname, non_null(:string)
    field :age, non_null(:integer)
    field :email, non_null(:string)
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
