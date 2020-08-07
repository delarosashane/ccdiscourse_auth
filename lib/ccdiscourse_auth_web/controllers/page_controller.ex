defmodule CcdiscourseAuthWeb.PageController do
  use CcdiscourseAuthWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
