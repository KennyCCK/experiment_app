module Api::V1
  class SeasonsController < ApiController
    before_action :verify_user, only: [:purchase]
    before_action :setup_season, only: [:purchase, :show]

    # GET localhost:3002/v1/seasons
    def index
      @seasons = parse_request(params[:movie_id])
      render json: @seasons, adapter: :json, root: 'entries', meta: @seasons.count, meta_key: 'total_count'
    end

    # GET localhost:3002/v1/seasons/:id
    def show
      @season = Season.find_by(id: params[:id])
      render json: @season, status: :ok
    end

    # POST localhost:3002/v1/seasons/:id/purchase
    def purchase
      unless @season
        render json: {message: 'Invalid season specified for purchase.'}, status: :bad_request
        return
      end

      price = Price.find_by(movie_id: @season.movie_id, season_id: @season.id)
      if check_library_exist(price)
        render json: {message: 'Same season already exist in library.'}, status: :unprocessable_entity
        return
      end

      begin
        # Create a transaction
        pc = PurchaseTransaction.new
        pc.user_id = @@current_user.id
        pc.purchase_type = price.price_type
        pc.purchase_quality = price.quality.name
        pc.purchase_price = price.price_usd
        pc.movie_id = @season.movie_id
        pc.season_id = @season.id
        pc.save

        # Add movie to user library
        t = Time.now + (price.valid_days).day
        ul = UserLibrary.new
        ul.user_id = @@current_user.id
        ul.purchase_transaction_id = pc.id
        ul.movie_id = @season.movie_id
        ul.season_id = @season.id
        ul.expiry_dt = t.strftime("%F %I:%M:%S")
        ul.save
      rescue => e
        render json: {message: 'Problem when processing transaction.'}, status: :unprocessable_entity
        return
      end

      render json: {message: 'purchased'}, status: :ok
    end

    private
      def setup_season
        @season = Season.find_by(id: params[:id])
      end

      def check_library_exist(price)
        t = Time.now + (price.valid_days).day
        exist = UserLibrary.where(movie_id: @season.movie_id, season_id: @season.id, expiry_dt: Time.now..t)
        if exist.present?
          return true
        end
        false
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