defmodule TwixWeb.Resolvers.Post do
  def add_like(%{id: id}, _context), do: Twix.add_like(id)
  def create(%{input: params}, _context), do: Twix.create_post(params)
end
