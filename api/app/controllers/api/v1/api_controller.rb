module Api::V1
  class ApiController < AuthController
    # skip_before_action :authenticate_user
    before_action :setup_user

    # Devise is loaded but temporary not using it,
    # instead requests are authenticated with user_id parameter
    def setup_user
      if params[:user_id]
        sign_in User.find_by(id: params[:user_id])
      else
        render json: {message: 'No user ID provided.'},status: :forbidden
        return
      end
    end

  end
end