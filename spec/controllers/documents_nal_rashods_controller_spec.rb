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

describe DocumentsNalRashodsController do

  # This should return the minimal set of attributes required to create a valid
  # DocumentsNalRashod. As you add validations to DocumentsNalRashod, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DocumentsNalRashodsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all documents_nal_rashods as @documents_nal_rashods" do
      documents_nal_rashod = DocumentsNalRashod.create! valid_attributes
      get :index, {}, valid_session
      assigns(:documents_nal_rashods).should eq([documents_nal_rashod])
    end
  end

  describe "GET show" do
    it "assigns the requested documents_nal_rashod as @documents_nal_rashod" do
      documents_nal_rashod = DocumentsNalRashod.create! valid_attributes
      get :show, {:id => documents_nal_rashod.to_param}, valid_session
      assigns(:documents_nal_rashod).should eq(documents_nal_rashod)
    end
  end

  describe "GET new" do
    it "assigns a new documents_nal_rashod as @documents_nal_rashod" do
      get :new, {}, valid_session
      assigns(:documents_nal_rashod).should be_a_new(DocumentsNalRashod)
    end
  end

  describe "GET edit" do
    it "assigns the requested documents_nal_rashod as @documents_nal_rashod" do
      documents_nal_rashod = DocumentsNalRashod.create! valid_attributes
      get :edit, {:id => documents_nal_rashod.to_param}, valid_session
      assigns(:documents_nal_rashod).should eq(documents_nal_rashod)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new DocumentsNalRashod" do
        expect {
          post :create, {:documents_nal_rashod => valid_attributes}, valid_session
        }.to change(DocumentsNalRashod, :count).by(1)
      end

      it "assigns a newly created documents_nal_rashod as @documents_nal_rashod" do
        post :create, {:documents_nal_rashod => valid_attributes}, valid_session
        assigns(:documents_nal_rashod).should be_a(DocumentsNalRashod)
        assigns(:documents_nal_rashod).should be_persisted
      end

      it "redirects to the created documents_nal_rashod" do
        post :create, {:documents_nal_rashod => valid_attributes}, valid_session
        response.should redirect_to(DocumentsNalRashod.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved documents_nal_rashod as @documents_nal_rashod" do
        # Trigger the behavior that occurs when invalid params are submitted
        DocumentsNalRashod.any_instance.stub(:save).and_return(false)
        post :create, {:documents_nal_rashod => {}}, valid_session
        assigns(:documents_nal_rashod).should be_a_new(DocumentsNalRashod)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        DocumentsNalRashod.any_instance.stub(:save).and_return(false)
        post :create, {:documents_nal_rashod => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested documents_nal_rashod" do
        documents_nal_rashod = DocumentsNalRashod.create! valid_attributes
        # Assuming there are no other documents_nal_rashods in the database, this
        # specifies that the DocumentsNalRashod created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        DocumentsNalRashod.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => documents_nal_rashod.to_param, :documents_nal_rashod => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested documents_nal_rashod as @documents_nal_rashod" do
        documents_nal_rashod = DocumentsNalRashod.create! valid_attributes
        put :update, {:id => documents_nal_rashod.to_param, :documents_nal_rashod => valid_attributes}, valid_session
        assigns(:documents_nal_rashod).should eq(documents_nal_rashod)
      end

      it "redirects to the documents_nal_rashod" do
        documents_nal_rashod = DocumentsNalRashod.create! valid_attributes
        put :update, {:id => documents_nal_rashod.to_param, :documents_nal_rashod => valid_attributes}, valid_session
        response.should redirect_to(documents_nal_rashod)
      end
    end

    describe "with invalid params" do
      it "assigns the documents_nal_rashod as @documents_nal_rashod" do
        documents_nal_rashod = DocumentsNalRashod.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DocumentsNalRashod.any_instance.stub(:save).and_return(false)
        put :update, {:id => documents_nal_rashod.to_param, :documents_nal_rashod => {}}, valid_session
        assigns(:documents_nal_rashod).should eq(documents_nal_rashod)
      end

      it "re-renders the 'edit' template" do
        documents_nal_rashod = DocumentsNalRashod.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DocumentsNalRashod.any_instance.stub(:save).and_return(false)
        put :update, {:id => documents_nal_rashod.to_param, :documents_nal_rashod => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested documents_nal_rashod" do
      documents_nal_rashod = DocumentsNalRashod.create! valid_attributes
      expect {
        delete :destroy, {:id => documents_nal_rashod.to_param}, valid_session
      }.to change(DocumentsNalRashod, :count).by(-1)
    end

    it "redirects to the documents_nal_rashods list" do
      documents_nal_rashod = DocumentsNalRashod.create! valid_attributes
      delete :destroy, {:id => documents_nal_rashod.to_param}, valid_session
      response.should redirect_to(documents_nal_rashods_url)
    end
  end

end