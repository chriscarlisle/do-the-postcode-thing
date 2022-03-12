class AdminController < Super::ApplicationController
  http_basic_authenticate_with name: "admin", password: "password"
end
