defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  alias Discuss.User

  plug Ueberauth
  
  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: topic_path(conn, :index))
  end

  def callback(conn, %{"provider" => provider} = params) do
    %{credentials: %{token: token},
      info: %{email: email,
              name: name}
    } = conn.assigns.ueberauth_auth

    user_params = %{token: token, email: email, name: name, provider: provider}
    changeset = User.changeset(%User{}, user_params)
    sign_in(conn, changeset)
  end

  defp sign_in(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok,    user}   ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))
      {:error, reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: topic_path(conn, :index))
    end

  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil   -> Repo.insert(changeset)
      user  -> {:ok, user}
    end
  end
end
