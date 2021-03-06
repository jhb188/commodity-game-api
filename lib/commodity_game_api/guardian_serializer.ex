defmodule CommodityGameApi.GuardianSerializer do
  @behaviour Guardian.Serializer
  alias CommodityGameApi.Repo
  alias CommodityGameApi.User
  def for_token(users = %User{}), do: {:ok, "Users:#{users.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}
  def from_token("Users:" <> id), do: {:ok, Repo.get(User, String.to_integer(id))}
  def from_token(_), do: {:error, "Unknown resource type"}
end
