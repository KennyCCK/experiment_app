module Api::V1
  class MoviesController < ApplicationController
    # GET localhost:3002/v1/movies
    def index
      @movies = parse_request(params[:filter_name])
      render json: @movies, status: :ok
    end

    # GET localhost:3002/v1/movies/:id
    def show
      @movie = Movie.find_by(id: params[:id])
      render json: @movie, status: :ok
    end

    # POST localhost:3002/v1/movies/:id/purchase
    def purchase
      render json: 'purchased', status: :ok
    end

    private
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