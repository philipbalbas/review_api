defmodule ReviewApi.Repo.Migrations.CreateExamsCards do
  use Ecto.Migration

  def change do
    create table(:exams_cards) do
      add :exam_id, references(:exams)
      add :card_id, references(:cards)
    end

    create unique_index(:exams_cards, [:exam_id, :card_id])
  end
end
