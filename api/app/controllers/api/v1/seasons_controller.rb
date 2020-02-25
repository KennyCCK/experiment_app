module Api::V1
  class SeasonsController < ApplicationController
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
      render json: 'purchased', status: :ok
    end

    private
      def parse_request(movie_id)
        if movie_id
          seasons = Season.where(movie_id: movie_id).order(created_at: :desc)
        else
          seasons = Season.order(created_at: :desc)
        end
        seasons
      end

  end
end