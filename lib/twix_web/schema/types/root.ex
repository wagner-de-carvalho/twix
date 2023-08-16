defmodule TwixWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation
  alias Crudry.Middlewares.TranslateErrors
  alias TwixWeb.Resolvers.User, as: UserResolver

  import_types TwixWeb.Schema.Types.User

  object :root_query do
    field :user, type: :user do
      arg :id, non_null(:id)

      resolve &UserResolver.get/2
      middleware TranslateErrors
    end
  end

  object :root_mutation do
    field :create_user, type: :user do
      arg :input, non_null(:create_user_input)

      resolve &UserResolver.create/2
      middleware TranslateErrors
    end

    field :update_user, type: :user do
      arg :input, non_null(:update_user_input)

      resolve &UserResolver.update/2
      middleware TranslateErrors
    end
  end
end
