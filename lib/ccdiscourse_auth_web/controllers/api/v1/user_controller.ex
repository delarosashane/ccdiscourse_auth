defmodule CcdiscourseAuthWeb.API.V1.UserController do
  use CcdiscourseAuthWeb, :controller

  action_fallback CcdiscourseAuthWeb.FallbackController

  def index(conn, _params) do
    users = [ExOauth2Provider.Plug.current_resource_owner(conn, otp_app: :ccdiscourse_auth)]
    render(conn, "index.json", users: users)
  end
end
