require_dependency Rails.root.join('lib', 'utility').to_s

module Api::V1
  class MoviesController < ApiController
    before_action :verify_user, :set_mode, :setup_quality, :setup_price, only: [:purchase]
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
      if Utility.check_library_exist(@movie.id, nil, @price)
        render json: {message: 'Same movie already exist in library.'}, status: :unprocessable_entity
        return
      end
      unless Utility.add_purchase('movie', @movie, nil, @price, @@current_user)
        render json: {message: 'Problem when processing transaction.'}, status: :unprocessable_entity
        return
      end
      render json: {message: 'Purchase Successful'}, status: :ok
    end

    private
      def set_mode
        @mode = 'movie'
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