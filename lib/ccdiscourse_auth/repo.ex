defmodule CcdiscourseAuth.Repo do
  use Ecto.Repo,
    otp_app: :ccdiscourse_auth,
    adapter: Ecto.Adapters.Postgres
end
