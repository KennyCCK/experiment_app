require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do

  let(:genre){ create(:genre) }
  let(:movie){ create(:movie, genre: genre) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do

    before do
      @movie = movie
    end

    it "returns http success" do
      get :show, params: { id: @movie.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /v1/movies/:id/purchase" do

    let(:user) { create(:user) }

    before do
      @quality = create(:quality)
      @season = create(:season, movie: movie)
      @episode = create(:episode, season: @season)
      @price = create(:price, quality: @quality, movie: movie, season: nil)
    end

    subject     { post :purchase, params: { id: movie.id, user_id: user.id, quality: @quality.name } }

    context 'first time purchase success' do

      it 'returns 200' do
        subject
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

    end

    context 'double purchase failure' do

      before do
        purchase_transaction = create(:purchase_transaction, user: user, purchase_type: @price.price_type, purchase_quality: @quality.name, purchase_price: @price.price_usd, movie: movie, season: nil)
        t = Time.now + (@price.valid_days).day
        expiry_dt = t.strftime("%F %I:%M:%S")
        user_library = create(:user_library, user: user, purchase_transaction: purchase_transaction, movie: movie, season: nil, expiry_dt: expiry_dt)
      end

      it 'returns 422' do
        subject
        expect(response.status).to eq(422)
      end

    end

  end

end
