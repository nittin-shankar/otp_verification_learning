defmodule OTPVerification.Repo do
  use Ecto.Repo,
    otp_app: :otp_verification,
    adapter: Ecto.Adapters.Postgres
end
