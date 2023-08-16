defmodule TwixWeb.Resolvers.Post do
  def create(%{input: params}, _context), do: Twix.create_post(params)
end
