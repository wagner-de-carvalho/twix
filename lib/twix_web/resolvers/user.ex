defmodule TwixWeb.Resolvers.User do
  def get(%{id: id}, _context), do: Twix.get_user(id)
end
