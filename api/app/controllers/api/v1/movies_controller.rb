module Api::V1
  class MoviesController < ApiController
    before_action :verify_user, only: [:purchase]
    before_action :setup_movie, only: [:purchase, :show]

    # GET localhost:3002/v1/movies
    def index
      @movies = parse_request(params[:filter_name])
      render json: @movies, status: :ok
    end

    # GET localhost:3002/v1/movies/:id
    def show
      render json: @movie, status: :ok
    end

    # POST localhost:3002/v1/movies/:id/purchase
    def purchase
      unless @movie
        render json: {message: 'Invalid movie specified for purchase.'}, status: :bad_request
        return
      end

      price = Price.find_by(movie_id: params[:id])
      if check_library_exist(price)
        render json: {message: 'Same movie already exist in library.'}, status: :unprocessable_entity
        return
      end

      begin
        # Create a transaction
        pc = PurchaseTransaction.new
        pc.user_id = @@current_user.id
        pc.purchase_type = price.price_type
        pc.purchase_quality = price.quality.name
        pc.purchase_price = price.price_usd
        pc.movie_id = @movie.id
        pc.season_id = nil
        pc.save

        # Add movie to user library
        t = Time.now + (price.valid_days).day
        ul = UserLibrary.new
        ul.user_id = @@current_user.id
        ul.purchase_transaction_id = pc.id
        ul.movie_id = @movie.id
        ul.season_id = nil
        ul.expiry_dt = t.strftime("%F %I:%M:%S")
        ul.save
      rescue => e
        render json: {message: 'Problem when processing transaction.'}, status: :unprocessable_entity
        return
      end

      render json: {message: 'purchased'}, status: :ok
    end

    private
      def setup_movie
        @movie = Movie.find_by(id: params[:id])
      end

      def check_library_exist(price)
        t = Time.now + (price.valid_days).day
        exist = UserLibrary.where(movie_id: @movie.id, expiry_dt: Time.now..t)
        if exist.present?
          return true
        end
        false
      end

      def parse_request(name)
        if name
          movies =
            Movie.select(:movie_name, :movie_desc, :created_at)
              .where(movie_name: name)
              .order(created_at: :desc)
              .as_json(except: :id)
        else
          movies =
            Movie.select(:movie_name, :movie_desc, :created_at)
              .order(created_at: :desc)
              .as_json(except: :id)
        end
        movies
      end
  end
end