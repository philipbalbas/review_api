defmodule ReviewApi.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :name, :string
      add :description, :string
      add :content, :text
      add :subject_id, references(:subjects, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:topics, [:name, :subject_id])
    create index(:topics, [:subject_id])
  end
end
