defmodule TwixWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation
  import_types TwixWeb.Schema.Types.User
  alias TwixWeb.Resolvers.User, as: UserResolver

  @doc """
  Works like a REST router, containing all queries available
  """
  object :root_query do
    field :user, type: :user do
      arg :id, non_null(:id)

      # Works like a controller
      # Gets the param and executes a function
      resolve &UserResolver.get/2
    end
  end

  object :root_mutation do
    field :create_user, type: :user do
      arg :input, non_null(:create_user_input)

      resolve &UserResolver.create/2
    end
  end
end
