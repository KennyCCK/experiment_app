class Utility
  class << self
    def add_purchase(type, movie=nil, season=nil, price=nil, current_user)

      case type
      when 'movie'
        movie_id = movie.id
        season_id = nil
      when 'season'
        movie_id = season.movie_id
        season_id = season.id
      end

      begin
        # Create a transaction
        pc = PurchaseTransaction.new
        pc.user_id = current_user.id
        pc.purchase_type = price.price_type
        pc.purchase_quality = price.quality.name
        pc.purchase_price = price.price_usd
        pc.movie_id = movie_id
        pc.season_id = season_id
        pc.save

        # Add movie to user library
        t = Time.now + (price.valid_days).day
        ul = UserLibrary.new
        ul.user_id = current_user.id
        ul.purchase_transaction_id = pc.id
        ul.movie_id = movie_id
        ul.season_id = season_id
        ul.expiry_dt = t.strftime("%F %I:%M:%S")
        ul.save
      rescue => e
        puts e
        return false
      end

      true
    end

    def check_library_exist(movie_id, season_id, price)
      t = Time.now + (price.valid_days).day
      if season_id
        reference = UserLibrary.where(movie_id: movie_id, season_id: season_id, expiry_dt: Time.now..t).includes(:purchase_transaction)
      else
        reference = UserLibrary.where(movie_id: movie_id, expiry_dt: Time.now..t).includes(:purchase_transaction)
      end
      if reference.present?
        reference.each do |lib|
          return true if lib.purchase_transaction.purchase_quality.upcase == price.quality.name.upcase
        end
      else
        return false
      end
      false
    end

  end
end