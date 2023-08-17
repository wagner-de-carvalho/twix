defmodule TwixWeb.Resolvers.User do
  alias TwixWeb.Endpoint

  def add_follower(%{input: %{user_id: user_id, follower_id: follower_id}}, _context) do
    user_id
    |> Twix.add_follower(follower_id)
    |> tap(&Absinthe.Subscription.publish(Endpoint, &1, new_follow: "new_follow_topic"))
  end

  def create(%{input: params}, _context), do: Twix.create_user(params)
  def get(%{id: id}, _context), do: Twix.get_user(id)
  def update(%{input: params}, _context), do: Twix.update_user(params)
end
