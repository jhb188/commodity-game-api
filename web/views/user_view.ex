defmodule CommodityGameApi.UserView do
  use CommodityGameApi.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, CommodityGameApi.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, CommodityGameApi.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      currency_units: user.currency_units}
  end
end
