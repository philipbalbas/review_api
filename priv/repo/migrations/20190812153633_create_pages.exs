defmodule ReviewApi.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :name, :string
      add :description, :string
      add :completed, :boolean, default: false, null: false
      add :content, :text
      add :topic_id, references(:topic, on_delete: :nothing)

      timestamps()
    end

    create index(:pages, [:topic_id])
  end
end
