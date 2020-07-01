defmodule ReviewApi.Repo.Migrations.ChangeQuestionAndRationaleToText do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      modify :question, :text
      modify :rationale, :text
    end
  end
end
