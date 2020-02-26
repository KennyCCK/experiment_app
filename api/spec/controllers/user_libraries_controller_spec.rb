require 'rails_helper'

RSpec.describe Api::V1::UserLibrariesController, type: :controller do

  describe "GET #index" do

    let(:user) { create(:user) }
    subject     { get :index, params: { user_id: user.id } }

    context 'user id provided' do

      before do
        @db_exist_count = UserLibrary.count
        3.times do
          quality = create(:quality)
          genre = create(:genre)
          movie = create(:movie, genre: genre)
          season = create(:season, movie: movie)
          episode = create(:episode, season: season)
          price = create(:price, quality: quality, movie: movie, season: season)
          purchase_transaction = create(:purchase_transaction, user: user, purchase_type: price.price_type, purchase_quality: quality.name, purchase_price: price.price_usd, movie: movie, season: season)
          t = Time.now + (price.valid_days).day
          expiry_dt = t.strftime("%F %I:%M:%S")
          user_library = create(:user_library, user: user, purchase_transaction: purchase_transaction, movie: movie, season: season, expiry_dt: expiry_dt)
        end
      end

      it 'returns all purchased libraries' do
        subject
        json = JSON.parse(response.body)
        all_library_count = UserLibrary.count - @db_exist_count
        expect(json['entries'].size).to eq(all_library_count)
        expect(json['total_count']).to eq(all_library_count)
      end

      it 'returns 200' do
        subject
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

    end

  end

end
