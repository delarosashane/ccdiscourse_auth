defmodule CcdiscourseAuth.OauthApplications.OauthApplication do
  use Ecto.Schema
  use ExOauth2Provider.Applications.Application, otp_app: :ccdiscourse_auth

  schema "oauth_applications" do
    application_fields()

    timestamps()
  end
end
