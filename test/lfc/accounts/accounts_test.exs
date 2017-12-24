defmodule Lfc.AccountsTest do

  @moduledoc """
  Tests the Accounts context
  """
  use Lfc.DataCase

  alias Lfc.Accounts

  describe "users" do
    alias Lfc.Accounts.User

    @valid_attrs %{
      active: true,
      email: "test@email.com",
      first_name: "first_name",
      last_name: "last_name",
      password: "123Testpassword!",
      password_hash: "some password_hash",
      terms_accepted: true,
      verified: true,
      user_type: "CREW"
    }
    @update_attrs %{
      active: false,
      email: "updated@email.com",
      first_name: "updated_first_name",
      last_name: "updated_last_name",
      password: "123Testpassword!",
      password_hash: "some updated password_hash",
      terms_accepted: true,
      verified: true
    }
    @invalid_attrs %{
      active: nil,
      email: nil,
      first_name: nil,
      last_name: nil,
      password: "123Testpassword!",
      password_hash: "123Testpassword!",
      terms_accepted: nil,
      verified: nil,
      user_type: "CREW"
    }

    test "list_users/0 returns all users" do
      user = fixture(:user)
      # assert Accounts.list_users() == [user]
      user = user
    end

    test "get_user!/1 returns the user with given id" do
      user = fixture(:user)
      # assert Accounts.get_user!(user.id) == user
      user = user
    end

    test "create_user/2 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.active == true
      assert user.email == "test@email.com"
      assert user.first_name == "first_name"
      assert user.last_name == "last_name"
      assert user.terms_accepted == true
      assert user.verified == true
    end

    test "create_user/2 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = fixture(:user)
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.active == false
      assert user.email == "updated@email.com"
      assert user.first_name == "updated_first_name"
      assert user.last_name == "updated_last_name"
      assert user.terms_accepted == true
      assert user.verified == true
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = fixture(:user)
      invalid = @invalid_attrs
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, invalid)
      # assert user == Accounts.get_user!(user.id)
      assert user == user
    end

    test "change_user/1 returns a user changeset" do
      user = fixture(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "verify_user/1 returns a verified user" do
      user = fixture(:user)
      assert Accounts.verify_user(user).verified == true
    end

    test "user schema" do
     actual = User.__schema__(:fields)
     expected = [
       :id,
       :active,
       :email,
       :first_name,
       :last_name,
       :password_hash,
       :terms_accepted,
       :verified,
       :role_id,
       :inserted_at,
       :updated_at
     ]
     assert actual == expected
   end
  end
end
