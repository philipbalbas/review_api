defmodule ReviewApi.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :street, :string
      add :city, :string
      add :email, :string
      add :phone, :string
      add :type, :string

      timestamps()
    end

    create unique_index(:organizations, [:name])
  end
end
