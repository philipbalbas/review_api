defmodule ReviewApi.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :question, :string
      add :rationale, :string
      add :type, :string
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:cards, [:question, :topic_id])
    create index(:cards, [:topic_id])
  end
end
