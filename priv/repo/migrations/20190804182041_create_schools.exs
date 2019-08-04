defmodule ReviewApi.Repo.Migrations.CreateSchools do
  use Ecto.Migration

  def change do
    create table(:schools) do
      add :name, :string
      add :street, :string
      add :city, :string
      add :email, :string
      add :phone, :string

      timestamps()
    end

  end
end
