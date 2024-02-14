defmodule TwixWeb.SchemaTest do
  @moduledoc false
  use TwixWeb.ConnCase, async: true

  describe "users query" do
    test "returns a user", %{conn: conn} do
      user_params = %{nickname: "josé", age: 35, email: "josevalim@mail.com"}

      {:ok, user} = Twix.create_user(user_params)

      query = """
      {
        user(id: #{user.id}) {
          nickname
          email
        }
      }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      assert response == %{
               "data" => %{"user" => %{"email" => "josevalim@mail.com", "nickname" => "josé"}}
             }
    end

    test "returns an error when user does not exist", %{conn: conn} do
      query = """
      {
        user(id: 999) {
          nickname
          email
        }
      }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      assert response == %{
               "data" => %{"user" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 3, "line" => 2}],
                   "message" => "not_found",
                   "path" => ["user"]
                 }
               ]
             }
    end
  end

  describe "users mutation" do
    test "when all params are valid creates a user", %{conn: conn} do
      query = """
      mutation {
          createUser(input: {age: 35, email: "josevalim@mail.com", nickname: "josé"}) {
          id
          nickname
        }
      }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      assert %{"data" => %{"createUser" => %{"id" => _id, "nickname" => "josé"}}} = response
    end
  end

  describe "subscriptions" do
    test "new follow", %{socket: socket} do
      user_params1 = %{nickname: "josé", age: 35, email: "josevalim@mail.com"}
      {:ok, user1} = Twix.create_user(user_params1)

      user_params2 = %{nickname: "acme", age: 55, email: "acmecompany@mail.com"}
      {:ok, user2} = Twix.create_user(user_params2)

      mutation = """
      mutation {
          addFollower(input: {userId: #{user1.id}, followerId: #{user2.id}}) {
          followerId
          followingId
        }
      }
      """

      subscription = """
      subscription {
          newFollow {
          followerId
          followingId
        }
      }
      """

      # Subscription setup
      socket_ref = push_doc(socket, subscription)
      assert_reply socket_ref, :ok, %{subscriptionId: subscription_id}
      # Subscription setup end

      # Mutation setup
      socket_ref = push_doc(socket, mutation)
      assert_reply socket_ref, :ok, mutation_response
      # Mutation setup end

      # Mutation assertion
      assert mutation_response == %{
               data: %{
                 "addFollower" => %{"followerId" => "#{user2.id}", "followingId" => "#{user1.id}"}
               }
             }

      # Subscription assertion
      assert_push "subscription:data", subscription_response

      assert subscription_response == %{
               result: %{
                 data: %{
                   "newFollow" => %{"followerId" => "#{user2.id}", "followingId" => "#{user1.id}"}
                 }
               },
               subscriptionId: subscription_id
             }
    end
  end
end
