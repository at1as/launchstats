defmodule Launchstats.PageController do
  use Launchstats.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
