defmodule TwixWeb.SchemaTest do
  use TwixWeb.ConnCase, async: true

  describe "users query" do
    test "returns a user", %{conn: conn} do
      user_params = %{nickname: "acme test", age: 33, email: "acmetest@mail.com"}
      {:ok, user} = Twix.create_user(user_params)

      query = """
        {
          user(id: #{user.id}) {
            email
            nickname
          }
        }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      expected_response = %{
        "data" => %{"user" => %{"nickname" => "acme test", "email" => "acmetest@mail.com"}}
      }

      assert response == expected_response
    end

    test "when there is no user, returns an error", %{conn: conn} do
      query = """
        {
          user(id: 999) {
            email
            nickname
          }
        }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      expected_response = %{
        "data" => %{"user" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "not_found",
            "path" => ["user"]
          }
        ]
      }

      assert response == expected_response
    end
  end

  describe "users mutation" do
    test "when all params are valid, creates a user", %{conn: conn} do
      query = """
          mutation {
          createUser(input: {age: 33, email: "acme@mail.com", nickname: "acme"}) {
            email
            nickname
          }
        }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      expected_response = %{
        "data" => %{"createUser" => %{"email" => "acme@mail.com", "nickname" => "acme"}}
      }

      assert response == expected_response
    end
  end

  describe "subscriptions" do
    test "new follow", %{socket: socket} do
      user_params1 = %{nickname: "acme test", age: 33, email: "acmetest@mail.com"}
      user_params2 = %{nickname: "acme follow", age: 43, email: "acmefollow@mail.com"}
      {:ok, user1} = Twix.create_user(user_params1)
      {:ok, user2} = Twix.create_user(user_params2)

      mutation = """
        mutation{
          addFollower(input:{followerId: #{user2.id}, userId: #{user1.id}}) {
            followerId
            followingId
          }
        }
      """

      subscription = """
        subscription{
          newFollow {
            followerId
            followingId
          }
        }
      """

      # Subscription SETUP
      socket_ref = push_doc(socket, subscription)
      assert_reply socket_ref, :ok, %{subscriptionId: subscription_id}

      # Mutation SETUP
      socket_ref = push_doc(socket, mutation)
      assert_reply socket_ref, :ok, mutation_response

      # ASSERTIONS
      expected_mutation_response = %{
        data: %{"addFollower" => %{"followerId" => "#{user2.id}", "followingId" => "#{user1.id}"}}
      }

      assert mutation_response == expected_mutation_response

      assert_push "subscription:data", subscription_response

      expected_subscription_response = %{
        result: %{
          data: %{"newFollow" => %{"followerId" => "#{user2.id}", "followingId" => "#{user1.id}"}}
        },
        subscriptionId: "#{subscription_id}"
      }

      assert subscription_response == expected_subscription_response
    end
  end
end
