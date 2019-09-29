defmodule ReviewApi.Repo.Migrations.AddCategoryIdToModule do
  use Ecto.Migration

  def change do
    alter table(:modules) do
      add :category_id, references(:categories, on_delete: :nothing)
    end

    create unique_index(:modules, [:name, :category_id])
    create index(:modules, [:category_id])
  end
end
