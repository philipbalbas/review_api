defmodule ReviewApi.Repo.Migrations.CreateExams do
  use Ecto.Migration

  def change do
    create table(:exams) do
      add :name, :string
      add :type, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:exams, [:name, :category_id])
    create index(:exams, [:category_id])
  end
end
