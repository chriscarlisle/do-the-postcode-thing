# frozen_string_literal: true

def basic_auth_header(username, password)
  { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
end
