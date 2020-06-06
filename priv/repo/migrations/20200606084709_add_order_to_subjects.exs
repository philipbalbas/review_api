defmodule ReviewApi.Repo.Migrations.AddOrderToSubjects do
  use Ecto.Migration

  def change do
    alter table(:subjects) do
      add :order, :integer
    end
  end
end
