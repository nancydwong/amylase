require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe BirstSpacesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # BirstSpace. As you add validations to BirstSpace, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.build(:birst_space).attributes
  }

  let(:invalid_attributes) {
    FactoryGirl.build(:birst_space, space_uuid: 'bad-uuid').attributes
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BirstSpacesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all birst_spaces as @birst_spaces" do
      birst_space = BirstSpace.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:birst_spaces)).to eq([birst_space])
    end
  end

  describe "GET show" do
    it "assigns the requested birst_space as @birst_space" do
      birst_space = BirstSpace.create! valid_attributes
      get :show, {:id => birst_space.to_param}, valid_session
      expect(assigns(:birst_space)).to eq(birst_space)
    end
  end

  describe "GET new" do
    it "assigns a new birst_space as @birst_space" do
      get :new, {}, valid_session
      expect(assigns(:birst_space)).to be_a_new(BirstSpace)
    end
  end

  describe "GET edit" do
    it "assigns the requested birst_space as @birst_space" do
      birst_space = BirstSpace.create! valid_attributes
      get :edit, {:id => birst_space.to_param}, valid_session
      expect(assigns(:birst_space)).to eq(birst_space)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BirstSpace" do
        expect {
          post :create, {:birst_space => valid_attributes}, valid_session
        }.to change(BirstSpace, :count).by(1)
      end

      it "assigns a newly created birst_space as @birst_space" do
        post :create, {:birst_space => valid_attributes}, valid_session
        expect(assigns(:birst_space)).to be_a(BirstSpace)
        expect(assigns(:birst_space)).to be_persisted
      end

      it "redirects to the created birst_space" do
        post :create, {:birst_space => valid_attributes}, valid_session
        expect(response).to redirect_to(BirstSpace.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved birst_space as @birst_space" do
        post :create, {:birst_space => invalid_attributes}, valid_session
        expect(assigns(:birst_space)).to be_a_new(BirstSpace)
      end

      it "re-renders the 'new' template" do
        post :create, {:birst_space => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        valid_attributes.merge({ 'space_type' => 'production' })
      }

      it "updates the requested birst_space" do
        birst_space = BirstSpace.create! valid_attributes
        put :update, {:id => birst_space.to_param, :birst_space => new_attributes}, valid_session
        birst_space.reload
        expect(birst_space.space_type).to eq 'production'
      end

      it "assigns the requested birst_space as @birst_space" do
        birst_space = BirstSpace.create! valid_attributes
        put :update, {:id => birst_space.to_param, :birst_space => valid_attributes}, valid_session
        expect(assigns(:birst_space)).to eq(birst_space)
      end

      it "redirects to the birst_space" do
        birst_space = BirstSpace.create! valid_attributes
        put :update, {:id => birst_space.to_param, :birst_space => valid_attributes}, valid_session
        expect(response).to redirect_to(birst_space)
      end
    end

    describe "with invalid params" do
      it "assigns the birst_space as @birst_space" do
        birst_space = BirstSpace.create! valid_attributes
        put :update, {:id => birst_space.to_param, :birst_space => invalid_attributes}, valid_session
        expect(assigns(:birst_space)).to eq(birst_space)
      end

      it "re-renders the 'edit' template" do
        birst_space = BirstSpace.create! valid_attributes
        put :update, {:id => birst_space.to_param, :birst_space => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested birst_space" do
      birst_space = BirstSpace.create! valid_attributes
      expect {
        delete :destroy, {:id => birst_space.to_param}, valid_session
      }.to change(BirstSpace, :count).by(-1)
    end

    it "redirects to the birst_spaces list" do
      birst_space = BirstSpace.create! valid_attributes
      delete :destroy, {:id => birst_space.to_param}, valid_session
      expect(response).to redirect_to(birst_spaces_url)
    end
  end

end
