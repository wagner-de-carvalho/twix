defmodule TwixWeb.Schema do
  @moduledoc false
  use Absinthe.Schema

  import_types TwixWeb.Schema.Types.Root

  query do
    import_fields :root_query
  end

  mutation do
    import_fields :root_mutation
  end
end
