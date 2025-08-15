defmodule TwixWeb.Resolvers.User do
  def create(%{input: params}, _context), do: Twix.create_user(params)
  def get(%{id: id}, _context), do: Twix.get_user(id)
  def update(%{input: params}, _context), do: Twix.update_user(params)
end
