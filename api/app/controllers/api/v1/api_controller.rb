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
      unless @@current_user || defined?(@@current_user)
        render json: {message: 'Not logged in!'}, status: :unauthorized
        return
      end
    end

    def setup_movie
      @movie = Movie.find_by(id: params[:id])
      unless @movie
        render json: {message: 'Invalid movie specified.'}, status: :bad_request
        return
      end
    end

    def setup_season
      @season = Season.find_by(id: params[:id])
      unless @season
        render json: {message: 'Invalid season specified.'}, status: :bad_request
        return
      end
    end

    def setup_quality
      unless params[:quality]
        render json: {message: 'Please specify quality for purchase.'}, status: :bad_request
        return
      end

      @quality = Quality.find_by(name: params[:quality].upcase)
      unless @quality
        render json: {message: 'Specified quality is not valid.'}, status: :bad_request
        return
      end
    end

    def setup_price
      case @mode
      when 'movie'
        @price = Price.find_by(movie_id: params[:id], quality_id: @quality.id)
      when 'season'
        @price = Price.find_by(season_id: params[:id], quality_id: @quality.id)
      else
        render json: {message: 'Mode not set.'}, status: :bad_request
        return
      end
      unless @price
        render json: {message: 'Pricing not found, wrong quality?'}, status: :bad_request
        return
      end
    end

  end
end