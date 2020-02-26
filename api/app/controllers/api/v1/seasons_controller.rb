require_dependency Rails.root.join('lib', 'utility').to_s

module Api::V1
  class SeasonsController < ApiController
    before_action :verify_user, :set_mode, :setup_quality, :setup_price, only: [:purchase]
    before_action :setup_season, only: [:purchase, :show]

    # GET localhost:3002/v1/seasons
    def index
      @seasons = parse_request(params[:movie_id])
      render json: @seasons, adapter: :json, root: 'entries', meta: @seasons.count, meta_key: 'total_count'
    end

    # GET localhost:3002/v1/seasons/:id
    def show
      render json: @season, status: :ok
    end

    # POST localhost:3002/v1/seasons/:id/purchase
    def purchase
      if Utility.check_library_exist(@season.movie_id, @season.id, @price)
        render json: {message: 'Same season already exist in library.'}, status: :unprocessable_entity
        return
      end
      unless Utility.add_purchase('season', nil, @season, @price, @@current_user)
        render json: {message: 'Problem when processing transaction.'}, status: :unprocessable_entity
        return
      end
      render json: {message: 'Purchase Successful'}, status: :ok
    end

    private
      def set_mode
        @mode = 'season'
      end

      def parse_request(movie_id)
        if movie_id
          seasons = Season.where(movie_id: movie_id).order(created_at: :desc).includes(:movie)
        else
          seasons = Season.order(created_at: :desc).includes(:movie)
        end
        seasons
      end

  end
end