defmodule ProfiloWeb.AuthController do
  use ProfiloWeb, :controller

  plug Ueberauth

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/api/FAILED")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
      conn
      |> put_flash(:info, "Successfully authenticated.")
      # |> put_session(:current_user, user)
      |> redirect(to: "/api/users")
  end

end
