defmodule OTPVerification.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :otp_secret, :string
      add :otp_last, :integer, default: 0
      add :name, :string
      add :trivia, :string

      timestamps()
    end
  end
end
