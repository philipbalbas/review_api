defmodule ReviewApi.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :name, :string
      add :description, :string
      add :content, :text
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:pages, [:name, :topic_id])
    create index(:pages, [:topic_id])
  end
end
