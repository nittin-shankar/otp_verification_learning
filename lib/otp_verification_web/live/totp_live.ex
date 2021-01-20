defmodule OTPVerificationWeb.TOTPLive do
  use OTPVerificationWeb, :live_view
  alias OTPVerification.Accounts
  alias OTPVerification.Repo
  alias OTPVerification.{Email, Mailer}

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user(%Accounts.User{})
    {:ok, 
    assign(socket, :changeset, changeset)
    |> assign(:status, "Email not sent")
    }
  end

  def handle_event("send_email", %{"user" => params}, socket) do
    email = params["email"]
    user = Accounts.get_user_by_email(email)
    secret = user.otp_secret
    if is_nil(user) do
      {:noreply, socket |> put_flash(:info, "No user found")}
    else
      totp = OneTimePassEcto.Base.gen_totp(secret, interval: 30)
      Email.verification_email(email, totp) |> Mailer.deliver_now()
      {:noreply, socket |> assign(status: "Email sent", user: user)}
    end
  end

  def handle_event("verify_otp", %{"user" => %{"otp" => otp}}, socket) do
    output = OneTimePassEcto.verify(%{"id" => socket.assigns.user.id, "totp" => otp}, Repo, Accounts.User)
    case output do
      {:ok, user} -> {:noreply, socket |> put_flash(:info, user.trivia)}
      {:error, message} -> {:noreply, socket |> put_flash(:info, message)}
    end
  end
end