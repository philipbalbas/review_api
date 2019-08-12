defmodule ReviewApi.AccountsTest do
  use ReviewApi.DataCase

  alias ReviewApi.Accounts

  describe "users" do
    alias ReviewApi.Accounts.User

    @valid_attrs %{email: "some email", exam_batch: "some exam_batch", first_name: "some first_name", last_name: "some last_name", password_hash: "some password_hash", role: "some role", username: "some username"}
    @update_attrs %{email: "some updated email", exam_batch: "some updated exam_batch", first_name: "some updated first_name", last_name: "some updated last_name", password_hash: "some updated password_hash", role: "some updated role", username: "some updated username"}
    @invalid_attrs %{email: nil, exam_batch: nil, first_name: nil, last_name: nil, password_hash: nil, role: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.exam_batch == "some exam_batch"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.password_hash == "some password_hash"
      assert user.role == "some role"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.exam_batch == "some updated exam_batch"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.password_hash == "some updated password_hash"
      assert user.role == "some updated role"
      assert user.username == "some updated username"
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

  describe "schools" do
    alias ReviewApi.Accounts.School

    @valid_attrs %{city: "some city", email: "some email", name: "some name", phone: "some phone", street: "some street"}
    @update_attrs %{city: "some updated city", email: "some updated email", name: "some updated name", phone: "some updated phone", street: "some updated street"}
    @invalid_attrs %{city: nil, email: nil, name: nil, phone: nil, street: nil}

    def school_fixture(attrs \\ %{}) do
      {:ok, school} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_school()

      school
    end

    test "list_schools/0 returns all schools" do
      school = school_fixture()
      assert Accounts.list_schools() == [school]
    end

    test "get_school!/1 returns the school with given id" do
      school = school_fixture()
      assert Accounts.get_school!(school.id) == school
    end

    test "create_school/1 with valid data creates a school" do
      assert {:ok, %School{} = school} = Accounts.create_school(@valid_attrs)
      assert school.city == "some city"
      assert school.email == "some email"
      assert school.name == "some name"
      assert school.phone == "some phone"
      assert school.street == "some street"
    end

    test "create_school/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_school(@invalid_attrs)
    end

    test "update_school/2 with valid data updates the school" do
      school = school_fixture()
      assert {:ok, %School{} = school} = Accounts.update_school(school, @update_attrs)
      assert school.city == "some updated city"
      assert school.email == "some updated email"
      assert school.name == "some updated name"
      assert school.phone == "some updated phone"
      assert school.street == "some updated street"
    end

    test "update_school/2 with invalid data returns error changeset" do
      school = school_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_school(school, @invalid_attrs)
      assert school == Accounts.get_school!(school.id)
    end

    test "delete_school/1 deletes the school" do
      school = school_fixture()
      assert {:ok, %School{}} = Accounts.delete_school(school)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_school!(school.id) end
    end

    test "change_school/1 returns a school changeset" do
      school = school_fixture()
      assert %Ecto.Changeset{} = Accounts.change_school(school)
    end
  end

  describe "organizations" do
    alias ReviewApi.Accounts.Organization

    @valid_attrs %{city: "some city", email: "some email", name: "some name", phone: "some phone", street: "some street"}
    @update_attrs %{city: "some updated city", email: "some updated email", name: "some updated name", phone: "some updated phone", street: "some updated street"}
    @invalid_attrs %{city: nil, email: nil, name: nil, phone: nil, street: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Accounts.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Accounts.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Accounts.create_organization(@valid_attrs)
      assert organization.city == "some city"
      assert organization.email == "some email"
      assert organization.name == "some name"
      assert organization.phone == "some phone"
      assert organization.street == "some street"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = Accounts.update_organization(organization, @update_attrs)
      assert organization.city == "some updated city"
      assert organization.email == "some updated email"
      assert organization.name == "some updated name"
      assert organization.phone == "some updated phone"
      assert organization.street == "some updated street"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_organization(organization, @invalid_attrs)
      assert organization == Accounts.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Accounts.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Accounts.change_organization(organization)
    end
  end

  describe "organizations" do
    alias ReviewApi.Accounts.Organization

    @valid_attrs %{city: "some city", email: "some email", name: "some name", phone: "some phone", street: "some street", type: "some type"}
    @update_attrs %{city: "some updated city", email: "some updated email", name: "some updated name", phone: "some updated phone", street: "some updated street", type: "some updated type"}
    @invalid_attrs %{city: nil, email: nil, name: nil, phone: nil, street: nil, type: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Accounts.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Accounts.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Accounts.create_organization(@valid_attrs)
      assert organization.city == "some city"
      assert organization.email == "some email"
      assert organization.name == "some name"
      assert organization.phone == "some phone"
      assert organization.street == "some street"
      assert organization.type == "some type"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = Accounts.update_organization(organization, @update_attrs)
      assert organization.city == "some updated city"
      assert organization.email == "some updated email"
      assert organization.name == "some updated name"
      assert organization.phone == "some updated phone"
      assert organization.street == "some updated street"
      assert organization.type == "some updated type"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_organization(organization, @invalid_attrs)
      assert organization == Accounts.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Accounts.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Accounts.change_organization(organization)
    end
  end
end
