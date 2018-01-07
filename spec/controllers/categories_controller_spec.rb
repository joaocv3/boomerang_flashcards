require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:valid_attributes) { { name: "Programming" } }
  let(:invalid_attributes) { { name: "" } }

  describe "GET #index" do
    it "returns a success response" do
      category = Category.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      category = Category.create! valid_attributes
      get :show, params: {id: category.to_param}
      expect(response).to be_success
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
      expect(assigns(:category)).to_not be_nil
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      category = Category.create! valid_attributes
      get :edit, params: {id: category.to_param}
      expect(response).to be_success
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, params: {category: valid_attributes}
        }.to change(Category, :count).by(1)
      end

      it "redirects to the created category" do
        post :create, params: {category: valid_attributes}
        expect(response).to redirect_to(Category.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        expect {
					post :create, params: {category: invalid_attributes}
        }.to change(Category, :count).by(0)
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attribute_value) { "Music" }
      let(:new_attributes) { { name: new_attribute_value } }

      it "updates the requested category" do
        category = Category.create! valid_attributes
        put :update, params: {id: category.to_param, category: new_attributes}
        category.reload
        expect(category.name).to eq(new_attribute_value)
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        put :update, params: {id: category.to_param, category: valid_attributes}
        expect(response).to redirect_to(category)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        category = Category.create! valid_attributes
        expect {
					put :update, params: {id: category.to_param, category: invalid_attributes}
        }.to change(Category, :count).by(0)
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, params: {id: category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = Category.create! valid_attributes
      delete :destroy, params: {id: category.to_param}
      expect(response).to redirect_to(categories_url)
    end
  end
end
