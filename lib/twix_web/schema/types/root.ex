defmodule TwixWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation

  import_types TwixWeb.Schema.Types.User

  object :root_query do
    field :user, type: :user do
      arg :id, non_null(:id)
    end
  end
end
