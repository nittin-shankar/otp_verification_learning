defmodule OTPVerification.Email do
  import Bamboo.Email

  def verification_email(to, otp) do
    base_email() # Build your default email then customize for welcome
    |> to(to)
    |> subject("Check out OTP")
    |> html_body("The OTP is: <strong>#{otp}</strong>")
  end

  defp base_email do
    new_email()
    |> from("myapp@example.com") # Set a default from
  end

end
