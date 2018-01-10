require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:category) { Category.create!(name: "Programming") }
  let(:subject) { Subject.create!(name: "Technique", category_id: category.id) }
  let(:valid_attributes) { { front: "What is memoization?",
   back:"Memoization or memoisation is an optimization technique used primarily to speed up computer programs by storing the results of expensive function calls and returning the cached result when the same inputs occur again. In ruby:
  @twitter_followers ||= twitter_user.followers
  twitter_user.followers will just be called if @twitter_followers is nil",
  subject_id: subject.id } }

  let(:invalid_attributes) { { front: "", back: "", subject_id: nil } }

  describe "GET #index" do
    it "returns a success response" do
      card = Card.create! valid_attributes
      get :index
      expect(response).to be_success
      expect(assigns(:cards)).to eq([card])
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      card = Card.create! valid_attributes
      get :show, params: {id: card.to_param}
      expect(response).to be_success
      expect(assigns(:card)).to eq(card)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_success
      expect(assigns(:card)).to_not be_nil
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      card = Card.create! valid_attributes
      get :edit, params: {id: card.to_param}
      expect(response).to be_success
      expect(assigns(:card)).to eq(card)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Card" do
        expect {
          post :create, params: {card: valid_attributes}
        }.to change(Card, :count).by(1)
      end

      it "redirects to the created card" do
        post :create, params: {card: valid_attributes}
        expect(response).to redirect_to(Card.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        expect {
          post :create, params: {card: invalid_attributes}
        }.to change(Card, :count).by(0)
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { front: "new front", back: "new back" } }

      it "updates the requested card" do
        card = Card.create! valid_attributes
        put :update, params: {id: card.to_param, card: new_attributes}
        card.reload
        expect(Card.last).to eq(card)
        expect(card.front).to eq("new front")
      end

      it "redirects to the card" do
        card = Card.create! valid_attributes
        put :update, params: {id: card.to_param, card: valid_attributes}
        expect(response).to redirect_to(card)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        card = Card.create! valid_attributes
        put :update, params: {id: card.to_param, card: invalid_attributes}
        expect(response).to be_success
        expect(card.front).to eq(valid_attributes[:front])
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested card" do
      card = Card.create! valid_attributes
      expect {
        delete :destroy, params: {id: card.to_param}
      }.to change(Card, :count).by(-1)
    end

    it "redirects to the cards list" do
      card = Card.create! valid_attributes
      delete :destroy, params: {id: card.to_param}
      expect(response).to redirect_to(cards_url)
    end
  end
end
