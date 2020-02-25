module Api::V1
  class AuthController < ApplicationController
    include Knock::Authenticable
    # before_action :authenticate_user

  end
end