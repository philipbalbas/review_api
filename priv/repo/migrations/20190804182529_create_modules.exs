defmodule ReviewApi.Repo.Migrations.CreateModules do
  use Ecto.Migration

  def change do
    create table(:modules) do
      add :name, :string
      add :description, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:modules, [:name, :category_id])
    create index(:modules, [:category_id])
  end
end
