defmodule ReviewApi.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :name, :string
      add :description, :string
      add :completed, :boolean, default: false, null: false
      add :module_id, references(:modules, on_delete: :nothing)

      timestamps()
    end

    create index(:subjects, [:module_id])
  end
end
