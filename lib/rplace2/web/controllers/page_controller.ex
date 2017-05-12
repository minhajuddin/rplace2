defmodule Rplace2.Web.PageController do
  use Rplace2.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
