defmodule TwixWeb.UsersJSON do
  @moduledoc false

  def index(%{data: %{users: users}}) do
    # %{users: for(user <- users, do: user(user))}
    %{users: Enum.map(users, &user/1)}
  end

  defp user(user) do
    %{id: user.id, age: user.age, email: user.email, nickname: user.nickname}
  end
end
