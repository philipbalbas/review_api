defmodule ReviewApi.Repo.Migrations.AddOrderToModules do
  use Ecto.Migration

  def change do
    alter table(:modules) do
      add :order, :integer
    end
  end
end
