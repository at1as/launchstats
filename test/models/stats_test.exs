defmodule Launchstats.StatsTest do
  use Launchstats.ModelCase

  alias Launchstats.Stats

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Stats.changeset(%Stats{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Stats.changeset(%Stats{}, @invalid_attrs)
    refute changeset.valid?
  end
end
