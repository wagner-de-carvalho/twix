defmodule TwixWeb.Resolvers.User do
  @moduledoc false

  def create(%{input: params}, _context), do: Twix.create_user(params)
  def get(%{id: id}, _context), do: Twix.get_user(id)
end
