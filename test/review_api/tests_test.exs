defmodule ReviewApi.TestsTest do
  use ReviewApi.DataCase

  alias ReviewApi.Tests

  describe "cards" do
    alias ReviewApi.Tests.Card

    @valid_attrs %{question: "some question", rationale: "some rationale"}
    @update_attrs %{question: "some updated question", rationale: "some updated rationale"}
    @invalid_attrs %{question: nil, rationale: nil}

    def card_fixture(attrs \\ %{}) do
      {:ok, card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tests.create_card()

      card
    end

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Tests.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Tests.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      assert {:ok, %Card{} = card} = Tests.create_card(@valid_attrs)
      assert card.question == "some question"
      assert card.rationale == "some rationale"
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tests.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      assert {:ok, %Card{} = card} = Tests.update_card(card, @update_attrs)
      assert card.question == "some updated question"
      assert card.rationale == "some updated rationale"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Tests.update_card(card, @invalid_attrs)
      assert card == Tests.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Tests.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Tests.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Tests.change_card(card)
    end
  end

  describe "choices" do
    alias ReviewApi.Tests.Choice

    @valid_attrs %{answer: "some answer"}
    @update_attrs %{answer: "some updated answer"}
    @invalid_attrs %{answer: nil}

    def choice_fixture(attrs \\ %{}) do
      {:ok, choice} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tests.create_choice()

      choice
    end

    test "list_choices/0 returns all choices" do
      choice = choice_fixture()
      assert Tests.list_choices() == [choice]
    end

    test "get_choice!/1 returns the choice with given id" do
      choice = choice_fixture()
      assert Tests.get_choice!(choice.id) == choice
    end

    test "create_choice/1 with valid data creates a choice" do
      assert {:ok, %Choice{} = choice} = Tests.create_choice(@valid_attrs)
      assert choice.answer == "some answer"
    end

    test "create_choice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tests.create_choice(@invalid_attrs)
    end

    test "update_choice/2 with valid data updates the choice" do
      choice = choice_fixture()
      assert {:ok, %Choice{} = choice} = Tests.update_choice(choice, @update_attrs)
      assert choice.answer == "some updated answer"
    end

    test "update_choice/2 with invalid data returns error changeset" do
      choice = choice_fixture()
      assert {:error, %Ecto.Changeset{}} = Tests.update_choice(choice, @invalid_attrs)
      assert choice == Tests.get_choice!(choice.id)
    end

    test "delete_choice/1 deletes the choice" do
      choice = choice_fixture()
      assert {:ok, %Choice{}} = Tests.delete_choice(choice)
      assert_raise Ecto.NoResultsError, fn -> Tests.get_choice!(choice.id) end
    end

    test "change_choice/1 returns a choice changeset" do
      choice = choice_fixture()
      assert %Ecto.Changeset{} = Tests.change_choice(choice)
    end
  end

  describe "exams" do
    alias ReviewApi.Tests.Exam

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def exam_fixture(attrs \\ %{}) do
      {:ok, exam} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tests.create_exam()

      exam
    end

    test "list_exams/0 returns all exams" do
      exam = exam_fixture()
      assert Tests.list_exams() == [exam]
    end

    test "get_exam!/1 returns the exam with given id" do
      exam = exam_fixture()
      assert Tests.get_exam!(exam.id) == exam
    end

    test "create_exam/1 with valid data creates a exam" do
      assert {:ok, %Exam{} = exam} = Tests.create_exam(@valid_attrs)
      assert exam.name == "some name"
    end

    test "create_exam/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tests.create_exam(@invalid_attrs)
    end

    test "update_exam/2 with valid data updates the exam" do
      exam = exam_fixture()
      assert {:ok, %Exam{} = exam} = Tests.update_exam(exam, @update_attrs)
      assert exam.name == "some updated name"
    end

    test "update_exam/2 with invalid data returns error changeset" do
      exam = exam_fixture()
      assert {:error, %Ecto.Changeset{}} = Tests.update_exam(exam, @invalid_attrs)
      assert exam == Tests.get_exam!(exam.id)
    end

    test "delete_exam/1 deletes the exam" do
      exam = exam_fixture()
      assert {:ok, %Exam{}} = Tests.delete_exam(exam)
      assert_raise Ecto.NoResultsError, fn -> Tests.get_exam!(exam.id) end
    end

    test "change_exam/1 returns a exam changeset" do
      exam = exam_fixture()
      assert %Ecto.Changeset{} = Tests.change_exam(exam)
    end
  end
end
