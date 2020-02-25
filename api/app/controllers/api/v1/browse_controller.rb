module Api::V1
  class BrowseController < ApplicationController
    # GET localhost:3002/v1/browse
    def index
      @movies = parse_request(params[:filter_name])
      render json: @movies, adapter: :json, root: 'entries', meta: @movies.count, meta_key: 'total_count'
    end

    private
      def parse_request(name)
        if name
          movies = Movie.where(movie_name: name).order(created_at: :desc)
        else
          movies = Movie.order(created_at: :desc)
        end
        movies
      end
  end
end