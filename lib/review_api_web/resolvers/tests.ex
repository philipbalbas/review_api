defmodule ReviewApiWeb.Resolvers.Tests do
  alias ReviewApi.Tests
  alias ReviewApiWeb.Schema.ChangesetErrors

  def list_cards(_, args, _) do
    {:ok, Tests.list_cards(args)}
  end

  @spec list_exams(any, any, any) :: {:ok, any}
  def list_exams(_, args, _) do
    {:ok, Tests.list_exams(args)}
  end

  def create_exam(_, %{input: input}, _) do
    case Tests.create_exam(input) do
      {:error, changeset} ->
        {:error,
         message: "Could not create exam", details: ChangesetErrors.error_details(changeset)}

      {:ok, exam} ->
        {:ok, exam}
    end
  end

  def update_exam(_, %{input: input}, _) do
    exam = Tests.get_exam!(input[:id])

    case Tests.update_exam(exam, input) do
      {:error, changeset} ->
        {:error,
         message: "Could not update exam", details: ChangesetErrors.error_details(changeset)}

      {:ok, exam} ->
        {:ok, exam}
    end
  end

  def create_card(_, %{input: input}, _) do
    case Tests.create_card(input) do
      {:error, changeset} ->
        {:error,
         message: "Could not create card", details: ChangesetErrors.error_details(changeset)}

      {:ok, card} ->
        {:ok, card}
    end
  end

  def create_choice(_, %{input: input}, _) do
    case Tests.create_choice(input) do
      {:error, changeset} ->
        {:error,
         message: "Could not create an input", details: ChangesetErrors.error_details(changeset)}

      {:ok, choice} ->
        {:ok, choice}
    end
  end

  def upsert_card_choices(_, %{input: input}, _) do
    card = ReviewApi.Tests.get_card!(input[:card_id])

    ReviewApi.Tests.upsert_card_choices(card, input)
  end

  def upsert_question_answers(_, %{input: input}, _) do
    question = ReviewApi.Tests.get_card!(input[:card_id])

    ReviewApi.Tests.upsert_question_answers(question, input)
  end

  def upsert_exam_cards(_, %{input: input}, _) do
    exam = ReviewApi.Tests.get_exam!(input[:exam_id])

    ReviewApi.Tests.upsert_exam_cards(exam, input)
  end
end
