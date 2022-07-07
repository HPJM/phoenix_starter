defmodule PhoenixStarter.Repo.Migrations.Foobar do
  use Ecto.Migration

  def change do
    create table :foobar do
      add :foo, :string
    end
  end
end
