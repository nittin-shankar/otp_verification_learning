defmodule OTPVerification.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :otp_last, :integer, default: 0
    field :otp_secret, :string
    field :trivia, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:otp_secret, :otp_last, :name, :trivia, :email])
    |> validate_required([:email])
    |> set_secret()
  end

  defp set_secret(changeset) do
    otp_secret = get_field(changeset, :otp_secret, false)
    if otp_secret do
      changeset
    else
      new_secret = OneTimePassEcto.Base.gen_secret(32)
      changeset |> put_change(:otp_secret, new_secret)
    end
  end
end
