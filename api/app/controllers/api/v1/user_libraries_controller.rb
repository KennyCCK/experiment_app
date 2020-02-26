module Api::V1
  class UserLibrariesController < ApiController
    before_action :verify_user

    # GET localhost:3002/v1/library?user_id=1
    def index
      @sortedLibs = parse_request(@@current_user.id)
      render json: @sortedLibs, adapter: :json, root: 'entries', meta: @sortedLibs.count, meta_key: 'total_count'
    end

    private
      def parse_request(id)
        libraries = UserLibrary.where(user_id: id).includes(:purchase_transaction)

        # Sort by least towards longest remaining
        libraries.sort_by { |lib| lib.remaining_time_seconds = lib.calc_remaining_time }
      end
  end
end
