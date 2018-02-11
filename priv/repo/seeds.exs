# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CommodityGameApi.Repo.insert!(%CommodityGameApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.
require List

Faker.start

defmodule CommodityGameApi.DatabaseSeeder do
  alias CommodityGameApi.Repo
  alias CommodityGameApi.User
  alias CommodityGameApi.CommoditySet
  alias CommodityGameApi.Commodity
  alias CommodityGameApi.CommodityItem
  alias CommodityGameApi.Buy
  alias CommodityGameApi.Sell
  alias CommodityGameApi.Transaction

  @models [
    User,
    CommoditySet,
    Commodity,
    CommodityItem,
    Buy,
    Sell,
  ]

  def clear do
    @models |> Enum.each(fn m -> Repo.delete_all m end)
  end

  def insert_user do
    Repo.insert! User.changeset(%User{}, %{
      username: Faker.Name.first_name <> Faker.String.base64,
      email: Faker.Internet.email,
      password: "password",
      currency_units: Enum.random(0..1000),
    })
  end

  def insert_commodity_set do
    Repo.insert! %CommoditySet{
      name: Faker.Pokemon.location,
    }
  end

  def insert_commodity(commodity_set_id) do
    Repo.insert! %Commodity{
      name: Faker.Superhero.name,
      scarcity: Enum.random(0..10000) / 100,
      image: Faker.Avatar.image_url(290, 290),
      commodity_set_id: commodity_set_id,
    }
  end

  def insert_commodity_item(user_id, commodity_id) do
    Repo.insert! %CommodityItem{
      user_id: user_id,
      commodity_id: commodity_id,
    }
  end

  def insert_buy(user, commodity_id) do
    Repo.insert! %Buy{
      user_id: user.id,
      commodity_id: commodity_id,
      amount: Enum.random(0..user.currency_units),
    }
  end

  def insert_sell(commodity_item) do
    Repo.insert! %Sell{
      user_id: commodity_item.user_id,
      commodity_item_id: commodity_item.id,
      commodity_id: commodity_item.commodity_id,
      amount: Enum.random(1001..999999),
    }
  end

  def insert_transaction(commodity_item, buyer_id, seller_id) do
    Repo.insert! %Transaction{
      commodity_item_id: commodity_item.id,
      commodity_id: commodity_item.commodity_id,
      buyer_id: buyer_id,
      seller_id: seller_id,
      amount: Enum.random(1001..999999),
    }
  end
end

CommodityGameApi.DatabaseSeeder.clear()

users = for _ <- 1..500,
  do: CommodityGameApi.DatabaseSeeder.insert_user()

commodity_sets = for _ <- 1..20,
  do: CommodityGameApi.DatabaseSeeder.insert_commodity_set()

# TODO: do this cleanly, without defining a temp variable
commodity_groups = for s <- commodity_sets,
  do: for _ <- 1..Enum.random(5..25),
    do: CommodityGameApi.DatabaseSeeder.insert_commodity(s.id)

commodities = List.flatten(commodity_groups)

# TODO: do this cleanly, without defining a temp variable
commodity_item_groups = for c <- commodities,
  do: for _ <- 1..(round(c.scarcity)),
    do: CommodityGameApi.DatabaseSeeder.insert_commodity_item(
      Enum.random(users).id,
      c.id
    )

commodity_items = List.flatten(commodity_item_groups)

buys = for c <- commodities,
  do: for u <- users,
    Enum.random(1..10) == 1,
    do: CommodityGameApi.DatabaseSeeder.insert_buy(u, c.id)

sells = for c <- commodities,
  do: for u <- users, Enum.random(0..3) == 1,
    do: Enum.filter(commodity_items, fn ci -> ci.user_id == u.id && ci.commodity_id == c.id end)
      |> List.first
      |> (fn first_ci -> if first_ci != nil, do: CommodityGameApi.DatabaseSeeder.insert_sell(first_ci) end).()

transactions = commodity_items
  |> Enum.map(
    fn ci -> 1..Enum.random(2..5)
      |> Enum.map(
        fn _ -> CommodityGameApi.DatabaseSeeder.insert_transaction(
          ci,
          Enum.random(users).id,
          Enum.random(users).id
        )
        end
      )
    end
  )
  |> List.flatten
