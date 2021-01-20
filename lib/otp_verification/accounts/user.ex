defmodule OTPVerification.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :otp_last, :integer
    field :otp_secret, :string
    field :trivia, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:otp_secret, :otp_last, :name, :trivia])
    |> validate_required([:otp_secret, :otp_last, :name, :trivia])
  end
end
