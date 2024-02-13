defmodule TwixWeb.Resolvers.Post do
  @moduledoc false

  def create(%{input: params}, _context), do: Twix.create_post(params)
end
