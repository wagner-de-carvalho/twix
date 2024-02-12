defmodule TwixWeb.Resolvers.User do
  @moduledoc false

  def get(%{id: id}, _context), do: Twix.get_user(id)
end
