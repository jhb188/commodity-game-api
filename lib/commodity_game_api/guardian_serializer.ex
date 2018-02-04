defmodule CommodityGameApi.GuardianSerializer do
  @behavior Guardian.Serializer
  alias CommodityGameApi.Repo
  alias CommodityGameApi.Users
  def for_token(users = %Users{}), do: {:ok, "Users:#{users.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}
  def from_token("Users:" <> id), do: {:ok, Repo.get(Users, String.to_integer(id))}
  def from_token(_), do: {:error, "Unknown resource type"}
end
