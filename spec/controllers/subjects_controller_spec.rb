require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  let(:category) { Category.create!(name: "programming") }
  let(:subject_name) { "Spanish" }
  let(:valid_attributes) { { name: subject_name, category_id: category.id } }

  let(:invalid_attributes) { { name: "", category_id: nil } }

  describe "GET #index" do
    it "returns a success response" do
      subject = Subject.create! valid_attributes
      get :index
      expect(response).to be_success
      expect(assigns(:subjects)).to eq([subject])
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      subject = Subject.create! valid_attributes
      get :show, params: {id: subject.to_param}
      expect(response).to be_success
      expect(assigns(:subject)).to eq(subject)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_success
      expect(assigns(:subject)).to_not be_nil
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      subject = Subject.create! valid_attributes
      get :edit, params: {id: subject.to_param}
      expect(response).to be_success
      expect(assigns(:subject)).to eq(subject)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Subject" do
        expect {
          post :create, params: {subject: valid_attributes}
        }.to change(Subject, :count).by(1)
      end

      it "redirects to the created subject" do
        post :create, params: {subject: valid_attributes}
        expect(response).to redirect_to(Subject.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        expect {
          post :create, params: {subject: invalid_attributes}
        }.to change(Subject, :count).by(0)
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:category) { Category.create!(name: "Languages") }
      let(:subject_name) { "Spanish" }
      let(:new_attributes) { { name: subject_name, category_id: category.id } }

      it "updates the requested subject" do
        subject = Subject.create! valid_attributes
        put :update, params: {id: subject.to_param, subject: new_attributes}
        subject.reload
        expect(Subject.last).to eq(subject)
      end

      it "redirects to the subject" do
        subject = Subject.create! valid_attributes
        put :update, params: {id: subject.to_param, subject: valid_attributes}
        expect(response).to redirect_to(subject)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        subject = Subject.create! valid_attributes
        expect {
          put :update, params: {id: subject.to_param, subject: invalid_attributes}
        }.to change(Subject, :count).by(0)
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested subject" do
      subject = Subject.create! valid_attributes
      expect {
        delete :destroy, params: {id: subject.to_param}
      }.to change(Subject, :count).by(-1)
    end

    it "redirects to the subjects list" do
      subject = Subject.create! valid_attributes
      delete :destroy, params: {id: subject.to_param}
      expect(response).to redirect_to(subjects_url)
    end
  end
end
