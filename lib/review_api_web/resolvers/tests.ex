defmodule ReviewApiWeb.Resolvers.Tests do
  alias ReviewApi.Tests
  alias ReviewApiWeb.Schema.ChangesetErrors

  def list_cards(_, args, _) do
    {:ok, Tests.list_cards(args)}
  end

  def list_choices(_, args, _) do
    {:ok, Tests.list_choices(args)}
  end

  def get_choice(%{id: id}, _) do
    {:ok, Tests.get_choice!(id)}
  end

  def list_exams(_, args, _) do
    {:ok, Tests.list_exams(args)}
  end

  def get_exam(%{id: id}, _) do
    {:ok, Tests.get_exam!(id)}
  end

  def create_exam(_, %{input_data: input}, _) do
    case Tests.create_exam(input) do
      {:error, changeset} ->
        {:error,
         message: "Could not create exam", details: ChangesetErrors.error_details(changeset)}

      {:ok, exam} ->
        {:ok, %{result: exam}}
    end
  end

  def update_exam(_, %{input_data: input}, _) do
    exam = Tests.get_exam!(input[:id])

    case Tests.update_exam(exam, input) do
      {:error, changeset} ->
        {:error,
         message: "Could not update exam", details: ChangesetErrors.error_details(changeset)}

      {:ok, exam} ->
        {:ok, %{result: exam}}
    end
  end

  def create_card(_, %{input_data: input}, _) do
    case Tests.create_card(input) do
      {:error, changeset} ->
        {:error,
         message: "Could not create card", details: ChangesetErrors.error_details(changeset)}

      {:ok, card} ->
        {:ok, %{result: card}}
    end
  end

  def create_choice(_, %{input_data: input}, _) do
    case Tests.create_choice(input) do
      {:error, changeset} ->
        {:error,
         message: "Could not create an input", details: ChangesetErrors.error_details(changeset)}

      {:ok, choice} ->
        {:ok, %{result: choice}}
    end
  end

  def update_choice(_, %{input_data: input}, _) do
    choice = Tests.get_choice!(input[:id])

    case Tests.update_choice(choice, input) do
      {:error, changeset} ->
        {:error,
         message: "Could not update an input", details: ChangesetErrors.error_details(changeset)}

      {:ok, choice} ->
        {:ok, %{result: choice}}
    end
  end

  def upsert_card_choices(_, %{input_data: input}, _) do
    card = ReviewApi.Tests.get_card!(input[:card_id])

    case ReviewApi.Tests.upsert_card_choices(card, input) do
      {:error, changeset} ->
        {:error,
         message: "Could not insert choice", details: ChangesetErrors.error_details(changeset)}

      {:ok, card} ->
        {:ok, %{result: card}}
    end
  end

  def upsert_card_answers(_, %{input_data: input}, _) do
    card = ReviewApi.Tests.get_card!(input[:card_id])

    case ReviewApi.Tests.upsert_card_answers(card, input) do
      {:error, changeset} ->
        {:error,
         message: "Could not insert answer", details: ChangesetErrors.error_details(changeset)}

      {:ok, card} ->
        {:ok, %{result: card}}
    end
  end

  def upsert_question_answers(_, %{input_data: input}, _) do
    question = ReviewApi.Tests.get_card!(input[:card_id])

    case ReviewApi.Tests.upsert_question_answers(question, input) do
      {:error, changeset} ->
        {:error,
         message: "Could not insert answer", details: ChangesetErrors.error_details(changeset)}

      {:ok, card} ->
        {:ok, %{result: card}}
    end
  end

  def upsert_exam_cards(_, %{input_data: input}, _) do
    exam = ReviewApi.Tests.get_exam!(input[:exam_id])

    case ReviewApi.Tests.upsert_exam_cards(exam, input) do
      {:error, changeset} ->
        {:error,
         message: "Could not insert card", details: ChangesetErrors.error_details(changeset)}

      {:ok, exam} ->
        {:ok, %{result: exam}}
    end
  end

  def upsert_card_exams(_, %{input_data: input}, _) do
    card = ReviewApi.Tests.get_card!(input[:card_id])

    case ReviewApi.Tests.upsert_card_exams(card, input) do
      {:error, changeset} ->
        {:error,
         message: "Could not insert exam", details: ChangesetErrors.error_details(changeset)}

      {:ok, card} ->
        {:ok, %{result: card}}
    end
  end

  def upsert_exam_topics(_, %{input_data: input}, _) do
    exam = ReviewApi.Tests.get_exam!(input[:exam_id])

    case ReviewApi.Tests.upsert_exam_topics(exam, input) do
      {:error, changeset} ->
        {:error,
         message: "Could not insert topic", details: ChangesetErrors.error_details(changeset)}

      {:ok, exam} ->
        {:ok, %{result: exam}}
    end
  end
end
