require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  let(:valid_attributes) {
    attributes_for(:bookmark)
  }

  let(:invalid_attributes) {
    attributes_for(:bookmark, title: nil)
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      bookmark = Bookmark.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      bookmark = Bookmark.create! valid_attributes
      get :edit, params: {id: bookmark.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Bookmark" do
        expect {
          post :create, params: {bookmark: valid_attributes}, session: valid_session
        }.to change(Bookmark, :count).by(1)
      end

      it "redirects to the created bookmark" do
        post :create, params: {bookmark: valid_attributes}, session: valid_session
        expect(response).to redirect_to(bookmarks_url)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {bookmark: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:bookmark, title: "New title")
      }

      it "updates the requested bookmark" do
        bookmark = Bookmark.create! valid_attributes
        put :update, params: {id: bookmark.to_param, bookmark: new_attributes}, session: valid_session
        bookmark.reload

        expect(bookmark.title).to eq "New title"
      end

      it "redirects to the bookmark" do
        bookmark = Bookmark.create! valid_attributes
        put :update, params: {id: bookmark.to_param, bookmark: valid_attributes}, session: valid_session
        expect(response).to redirect_to(bookmarks_url)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        bookmark = Bookmark.create! valid_attributes
        put :update, params: {id: bookmark.to_param, bookmark: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested bookmark" do
      bookmark = Bookmark.create! valid_attributes
      expect {
        delete :destroy, params: {id: bookmark.to_param}, session: valid_session
      }.to change(Bookmark, :count).by(-1)
    end

    it "redirects to the bookmarks list" do
      bookmark = Bookmark.create! valid_attributes
      delete :destroy, params: {id: bookmark.to_param}, session: valid_session
      expect(response).to redirect_to(bookmarks_url)
    end
  end

end
