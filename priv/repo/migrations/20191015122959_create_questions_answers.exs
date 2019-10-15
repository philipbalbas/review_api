defmodule ReviewApi.Repo.Migrations.CreateQuestionsAnswers do
  use Ecto.Migration

  def change do
    create table(:questions_answers) do
      add :card_id, references(:cards)
      add :choice_id, references(:choices)
    end

    create unique_index(:questions_answers, [:card_id, :choice_id])
  end
end
