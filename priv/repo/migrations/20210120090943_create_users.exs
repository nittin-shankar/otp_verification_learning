defmodule OTPVerification.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :otp_secret, :string
      add :otp_last, :integer
      add :name, :string
      add :trivia, :string

      timestamps()
    end
  end
end
