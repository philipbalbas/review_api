defmodule ReviewApi.LectureTest do
  use ReviewApi.DataCase

  alias ReviewApi.Lecture

  describe "modules" do
    alias ReviewApi.Lecture.Module

    @valid_attrs %{completed: true, description: "some description", name: "some name"}
    @update_attrs %{
      completed: false,
      description: "some updated description",
      name: "some updated name"
    }
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

  describe "subjects" do
    alias ReviewApi.Lecture.Subject

    @valid_attrs %{completed: true, description: "some description", name: "some name"}
    @update_attrs %{
      completed: false,
      description: "some updated description",
      name: "some updated name"
    }
    @invalid_attrs %{completed: nil, description: nil, name: nil}

    def subject_fixture(attrs \\ %{}) do
      {:ok, subject} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lecture.create_subject()

      subject
    end

    test "list_subjects/0 returns all subjects" do
      subject = subject_fixture()
      assert Lecture.list_subjects() == [subject]
    end

    test "get_subject!/1 returns the subject with given id" do
      subject = subject_fixture()
      assert Lecture.get_subject!(subject.id) == subject
    end

    test "create_subject/1 with valid data creates a subject" do
      assert {:ok, %Subject{} = subject} = Lecture.create_subject(@valid_attrs)
      assert subject.completed == true
      assert subject.description == "some description"
      assert subject.name == "some name"
    end

    test "create_subject/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lecture.create_subject(@invalid_attrs)
    end

    test "update_subject/2 with valid data updates the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{} = subject} = Lecture.update_subject(subject, @update_attrs)
      assert subject.completed == false
      assert subject.description == "some updated description"
      assert subject.name == "some updated name"
    end

    test "update_subject/2 with invalid data returns error changeset" do
      subject = subject_fixture()
      assert {:error, %Ecto.Changeset{}} = Lecture.update_subject(subject, @invalid_attrs)
      assert subject == Lecture.get_subject!(subject.id)
    end

    test "delete_subject/1 deletes the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{}} = Lecture.delete_subject(subject)
      assert_raise Ecto.NoResultsError, fn -> Lecture.get_subject!(subject.id) end
    end

    test "change_subject/1 returns a subject changeset" do
      subject = subject_fixture()
      assert %Ecto.Changeset{} = Lecture.change_subject(subject)
    end
  end

  describe "topics" do
    alias ReviewApi.Lecture.Topic

    @valid_attrs %{
      completed: true,
      content: "some content",
      description: "some description",
      name: "some name"
    }
    @update_attrs %{
      completed: false,
      content: "some updated content",
      description: "some updated description",
      name: "some updated name"
    }
    @invalid_attrs %{completed: nil, content: nil, description: nil, name: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lecture.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Lecture.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Lecture.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Lecture.create_topic(@valid_attrs)
      assert topic.completed == true
      assert topic.content == "some content"
      assert topic.description == "some description"
      assert topic.name == "some name"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lecture.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{} = topic} = Lecture.update_topic(topic, @update_attrs)
      assert topic.completed == false
      assert topic.content == "some updated content"
      assert topic.description == "some updated description"
      assert topic.name == "some updated name"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Lecture.update_topic(topic, @invalid_attrs)
      assert topic == Lecture.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Lecture.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Lecture.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Lecture.change_topic(topic)
    end
  end

  describe "pages" do
    alias ReviewApi.Lecture.Page

    @valid_attrs %{
      completed: true,
      content: "some content",
      description: "some description",
      name: "some name"
    }
    @update_attrs %{
      completed: false,
      content: "some updated content",
      description: "some updated description",
      name: "some updated name"
    }
    @invalid_attrs %{completed: nil, content: nil, description: nil, name: nil}

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lecture.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Lecture.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Lecture.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Lecture.create_page(@valid_attrs)
      assert page.completed == true
      assert page.content == "some content"
      assert page.description == "some description"
      assert page.name == "some name"
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lecture.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, %Page{} = page} = Lecture.update_page(page, @update_attrs)
      assert page.completed == false
      assert page.content == "some updated content"
      assert page.description == "some updated description"
      assert page.name == "some updated name"
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Lecture.update_page(page, @invalid_attrs)
      assert page == Lecture.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Lecture.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Lecture.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Lecture.change_page(page)
    end
  end

  describe "notes" do
    alias ReviewApi.Lecture.Note

    @valid_attrs %{
      completed: true,
      content: "some content",
      description: "some description",
      name: "some name"
    }
    @update_attrs %{
      completed: false,
      content: "some updated content",
      description: "some updated description",
      name: "some updated name"
    }
    @invalid_attrs %{completed: nil, content: nil, description: nil, name: nil}

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lecture.create_note()

      note
    end

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Lecture.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Lecture.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} = Lecture.create_note(@valid_attrs)
      assert note.completed == true
      assert note.content == "some content"
      assert note.description == "some description"
      assert note.name == "some name"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lecture.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, %Note{} = note} = Lecture.update_note(note, @update_attrs)
      assert note.completed == false
      assert note.content == "some updated content"
      assert note.description == "some updated description"
      assert note.name == "some updated name"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Lecture.update_note(note, @invalid_attrs)
      assert note == Lecture.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Lecture.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Lecture.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Lecture.change_note(note)
    end
  end

  describe "categories" do
    alias ReviewApi.Lecture.Category

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lecture.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Lecture.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Lecture.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Lecture.create_category(@valid_attrs)
      assert category.description == "some description"
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lecture.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Lecture.update_category(category, @update_attrs)
      assert category.description == "some updated description"
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Lecture.update_category(category, @invalid_attrs)
      assert category == Lecture.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Lecture.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Lecture.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Lecture.change_category(category)
    end
  end
end
