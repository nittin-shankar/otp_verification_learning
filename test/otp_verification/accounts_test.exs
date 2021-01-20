defmodule OTPVerification.AccountsTest do
  use OTPVerification.DataCase

  alias OTPVerification.Accounts

  describe "users" do
    alias OTPVerification.Accounts.User

    import OTPVerification.AccountsFixtures

    @invalid_attrs %{name: nil, otp_last: nil, otp_secret: nil, trivia: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", otp_last: 42, otp_secret: "some otp_secret", trivia: "some trivia"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.otp_last == 42
      assert user.otp_secret == "some otp_secret"
      assert user.trivia == "some trivia"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name", otp_last: 43, otp_secret: "some updated otp_secret", trivia: "some updated trivia"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.otp_last == 43
      assert user.otp_secret == "some updated otp_secret"
      assert user.trivia == "some updated trivia"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
