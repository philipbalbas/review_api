defmodule ReviewApi.Repo.Migrations.CreateModules do
  use Ecto.Migration

  def change do
    create table(:modules) do
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end
