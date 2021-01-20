defmodule OTPVerificationWeb.TOTPLive do
  use OTPVerificationWeb, :live_view
  alias OTPVerification.Accounts

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user(%Accounts.User{})
    {:ok, 
    assign(socket, :changeset, changeset)
    |> assign(:status, "Email not sent")
    }
  end

  def handle_event("send_email", %{"user" => params}, socket ) do
    {:noreply, socket}
  end
end