defmodule ReviewApi.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :name, :string
      add :description, :string
      add :content, :text
      add :page_id, references(:pages, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:notes, [:name, :page_id])
    create index(:notes, [:page_id])
  end
end
