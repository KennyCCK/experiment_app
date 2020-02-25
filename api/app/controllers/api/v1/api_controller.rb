module Api::V1
  class ApiController < AuthController
    # skip_before_action :authenticate_user
    before_action :setup_user

    # Devise is preferred but temporary not using it,
    # instead requests are authenticated with user_id parameter
    def setup_user
      if params[:user_id]
        @@current_user = User.find_by(id: params[:user_id])
      end
    end

    def verify_user
      unless @@current_user
        render json: {message: 'Not logged in!'}, status: :unauthorized
        return
      end
    end

  end
end