defmodule OTPVerification.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OTPVerification.Accounts` context.
  """

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name",
        otp_last: 42,
        otp_secret: "some otp_secret",
        trivia: "some trivia"
      })
      |> OTPVerification.Accounts.create_user()

    user
  end
end
