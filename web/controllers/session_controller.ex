defmodule CommodityGameApi.SessionsController do
  use CommodityGameApi.Web, :controller
  alias CommodityGameApi.Users

  def create(conn, %{"username" => username, "password" => password}) do
    case authenticate(%{"username" => username, "password" => password}) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user, :access)
        jwt = Guardian.Plug.current_token(new_conn)
        new_conn
        |> put_status(:created)
        |> render("show.json", user: user, jwt: jwt)
      :error ->
        conn
        |> put_status(:unauthorized)
    end
  end

  defp authenticate(%{"username" => username, "password" => password}) do
    user = Repo.get_by(Users, username: username)
    case check_password(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp check_password(nil, _), do: Comeonin.Bcrypt.dummy_checkpw()

  defp check_password(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.password_hash)
  end
end
