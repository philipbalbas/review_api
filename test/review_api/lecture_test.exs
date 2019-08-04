defmodule ReviewApi.LectureTest do
  use ReviewApi.DataCase

  alias ReviewApi.Lecture

  describe "modules" do
    alias ReviewApi.Lecture.Module

    @valid_attrs %{completed: true, description: "some description", name: "some name"}
    @update_attrs %{completed: false, description: "some updated description", name: "some updated name"}
    @invalid_attrs %{completed: nil, description: nil, name: nil}

    def module_fixture(attrs \\ %{}) do
      {:ok, module} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lecture.create_module()

      module
    end

    test "list_modules/0 returns all modules" do
      module = module_fixture()
      assert Lecture.list_modules() == [module]
    end

    test "get_module!/1 returns the module with given id" do
      module = module_fixture()
      assert Lecture.get_module!(module.id) == module
    end

    test "create_module/1 with valid data creates a module" do
      assert {:ok, %Module{} = module} = Lecture.create_module(@valid_attrs)
      assert module.completed == true
      assert module.description == "some description"
      assert module.name == "some name"
    end

    test "create_module/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lecture.create_module(@invalid_attrs)
    end

    test "update_module/2 with valid data updates the module" do
      module = module_fixture()
      assert {:ok, %Module{} = module} = Lecture.update_module(module, @update_attrs)
      assert module.completed == false
      assert module.description == "some updated description"
      assert module.name == "some updated name"
    end

    test "update_module/2 with invalid data returns error changeset" do
      module = module_fixture()
      assert {:error, %Ecto.Changeset{}} = Lecture.update_module(module, @invalid_attrs)
      assert module == Lecture.get_module!(module.id)
    end

    test "delete_module/1 deletes the module" do
      module = module_fixture()
      assert {:ok, %Module{}} = Lecture.delete_module(module)
      assert_raise Ecto.NoResultsError, fn -> Lecture.get_module!(module.id) end
    end

    test "change_module/1 returns a module changeset" do
      module = module_fixture()
      assert %Ecto.Changeset{} = Lecture.change_module(module)
    end
  end
end
