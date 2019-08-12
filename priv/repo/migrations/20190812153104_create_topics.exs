defmodule ReviewApi.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :name, :string
      add :description, :string
      add :completed, :boolean, default: false, null: false
      add :content, :text
      add :subject_id, references(:subjects, on_delete: :nothing)

      timestamps()
    end

    create index(:topics, [:subject_id])
  end
end
