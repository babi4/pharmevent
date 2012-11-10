require 'spec_helper'

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

describe DocumentsNalPrihodsController do

  # This should return the minimal set of attributes required to create a valid
  # DocumentsNalPrihod. As you add validations to DocumentsNalPrihod, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DocumentsNalPrihodsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all documents_nal_prihods as @documents_nal_prihods" do
      documents_nal_prihod = DocumentsNalPrihod.create! valid_attributes
      get :index, {}, valid_session
      assigns(:documents_nal_prihods).should eq([documents_nal_prihod])
    end
  end

  describe "GET show" do
    it "assigns the requested documents_nal_prihod as @documents_nal_prihod" do
      documents_nal_prihod = DocumentsNalPrihod.create! valid_attributes
      get :show, {:id => documents_nal_prihod.to_param}, valid_session
      assigns(:documents_nal_prihod).should eq(documents_nal_prihod)
    end
  end

  describe "GET new" do
    it "assigns a new documents_nal_prihod as @documents_nal_prihod" do
      get :new, {}, valid_session
      assigns(:documents_nal_prihod).should be_a_new(DocumentsNalPrihod)
    end
  end

  describe "GET edit" do
    it "assigns the requested documents_nal_prihod as @documents_nal_prihod" do
      documents_nal_prihod = DocumentsNalPrihod.create! valid_attributes
      get :edit, {:id => documents_nal_prihod.to_param}, valid_session
      assigns(:documents_nal_prihod).should eq(documents_nal_prihod)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new DocumentsNalPrihod" do
        expect {
          post :create, {:documents_nal_prihod => valid_attributes}, valid_session
        }.to change(DocumentsNalPrihod, :count).by(1)
      end

      it "assigns a newly created documents_nal_prihod as @documents_nal_prihod" do
        post :create, {:documents_nal_prihod => valid_attributes}, valid_session
        assigns(:documents_nal_prihod).should be_a(DocumentsNalPrihod)
        assigns(:documents_nal_prihod).should be_persisted
      end

      it "redirects to the created documents_nal_prihod" do
        post :create, {:documents_nal_prihod => valid_attributes}, valid_session
        response.should redirect_to(DocumentsNalPrihod.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved documents_nal_prihod as @documents_nal_prihod" do
        # Trigger the behavior that occurs when invalid params are submitted
        DocumentsNalPrihod.any_instance.stub(:save).and_return(false)
        post :create, {:documents_nal_prihod => {}}, valid_session
        assigns(:documents_nal_prihod).should be_a_new(DocumentsNalPrihod)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        DocumentsNalPrihod.any_instance.stub(:save).and_return(false)
        post :create, {:documents_nal_prihod => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested documents_nal_prihod" do
        documents_nal_prihod = DocumentsNalPrihod.create! valid_attributes
        # Assuming there are no other documents_nal_prihods in the database, this
        # specifies that the DocumentsNalPrihod created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        DocumentsNalPrihod.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => documents_nal_prihod.to_param, :documents_nal_prihod => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested documents_nal_prihod as @documents_nal_prihod" do
        documents_nal_prihod = DocumentsNalPrihod.create! valid_attributes
        put :update, {:id => documents_nal_prihod.to_param, :documents_nal_prihod => valid_attributes}, valid_session
        assigns(:documents_nal_prihod).should eq(documents_nal_prihod)
      end

      it "redirects to the documents_nal_prihod" do
        documents_nal_prihod = DocumentsNalPrihod.create! valid_attributes
        put :update, {:id => documents_nal_prihod.to_param, :documents_nal_prihod => valid_attributes}, valid_session
        response.should redirect_to(documents_nal_prihod)
      end
    end

    describe "with invalid params" do
      it "assigns the documents_nal_prihod as @documents_nal_prihod" do
        documents_nal_prihod = DocumentsNalPrihod.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DocumentsNalPrihod.any_instance.stub(:save).and_return(false)
        put :update, {:id => documents_nal_prihod.to_param, :documents_nal_prihod => {}}, valid_session
        assigns(:documents_nal_prihod).should eq(documents_nal_prihod)
      end

      it "re-renders the 'edit' template" do
        documents_nal_prihod = DocumentsNalPrihod.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DocumentsNalPrihod.any_instance.stub(:save).and_return(false)
        put :update, {:id => documents_nal_prihod.to_param, :documents_nal_prihod => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested documents_nal_prihod" do
      documents_nal_prihod = DocumentsNalPrihod.create! valid_attributes
      expect {
        delete :destroy, {:id => documents_nal_prihod.to_param}, valid_session
      }.to change(DocumentsNalPrihod, :count).by(-1)
    end

    it "redirects to the documents_nal_prihods list" do
      documents_nal_prihod = DocumentsNalPrihod.create! valid_attributes
      delete :destroy, {:id => documents_nal_prihod.to_param}, valid_session
      response.should redirect_to(documents_nal_prihods_url)
    end
  end

end
