defmodule TwixWeb.Resolvers.User do
  alias TwixWeb.Endpoint

  @topic "new_follow_topic"

  def add_follower(%{input: %{user_id: user_id, follower_id: follower_id}}, _context) do
    with {:ok, result} <- Twix.add_follower(user_id, follower_id) do
      Absinthe.Subscription.publish(Endpoint, result, new_follow: @topic)
      {:ok, result}
    end
  end

  @spec create(
          %{
            :input => :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any},
            optional(any) => any
          },
          any
        ) :: any
  def create(%{input: params}, _context), do: Twix.create_user(params)
  def get(%{id: id}, _context), do: Twix.get_user(id)
  def update(%{input: params}, _context), do: Twix.update_user(params)
end
