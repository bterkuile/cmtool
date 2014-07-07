require 'spec_helper'

describe Cmtool::ContactFormsController, type: :controller do
  routes { Cmtool::Engine.routes }
  before :each do
    sign_in @user
  end

  describe 'no user is signed in' do
    before :each do
      sign_out @user
    end
    it "should not allow acces when no user is logged in" do
      contact_form = create :contact_form
      get :index
      response.should be_redirect
    end

    it "should add a subscription without authentication" do
      @request.env['HTTP_REFERER'] = '/'
      expect {
        post :add, contact_form: {email: "unauthenticated@example.com"}
      }.to change(Cmtool::ContactForm, :count).by(1)
    end
  end

  describe "GET index" do
    it "assigns all contact_forms as @contact_forms" do
      contact_form = create :contact_form
      get :index
      assigns(:contact_forms).should eq([contact_form])
    end
  end

  describe "GET show" do
    it "assigns the requested contact_form as @contact_form" do
      contact_form = create :contact_form
      get :show, :id => contact_form.id
      assigns(:contact_form).should eq(contact_form)
    end
  end

  describe "GET new" do
    it "assigns a new contact_form as @contact_form" do
      get :new
      assigns(:contact_form).should be_a_new(Cmtool::ContactForm)
    end
  end

  describe "GET edit" do
    it "assigns the requested contact_form as @contact_form" do
      contact_form = create :contact_form
      get :edit, :id => contact_form.id
      assigns(:contact_form).should eq(contact_form)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Cmtool::ContactForm" do
        expect {
          post :create, :contact_form => build(:contact_form).attributes
        }.to change(Cmtool::ContactForm, :count).by(1)
      end

      it "assigns a newly created contact_form as @contact_form" do
        post :create, :contact_form => build(:contact_form).attributes
        assigns(:contact_form).should be_a(Cmtool::ContactForm)
        assigns(:contact_form).should be_persisted
      end

      it "redirects to the contact_forms contact_form" do
        post :create, :contact_form => build(:contact_form).attributes
        response.should redirect_to(Cmtool::ContactForm.last)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested contact_form" do
        contact_form = create(:contact_form)
        # Assuming there are no other contact_forms in the database, this
        # specifies that the Cmtool::ContactForm created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Cmtool::ContactForm.any_instance.should_receive(:update_attributes).with({'name' => 'Zeikurt'})
        put :update, :id => contact_form.id, :contact_form => {'name' => 'Zeikurt'}
      end

      it "assigns the requested contact_form as @contact_form" do
        contact_form = create(:contact_form)
        put :update, :id => contact_form.id, :contact_form => contact_form.attributes
        assigns(:contact_form).should eq(contact_form)
      end

      it "redirects to the contact_form" do
        contact_form = create(:contact_form)
        put :update, :id => contact_form.id, :contact_form => contact_form.attributes
        response.should redirect_to(contact_form)
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested contact_form" do
      @request.env['HTTP_REFERER'] = contact_forms_path
      contact_form = create(:contact_form)
      expect {
        delete :destroy, :id => contact_form.id
      }.to change(Cmtool::ContactForm, :count).by(-1)
    end

    it "redirects to the contact_forms list" do
      @request.env['HTTP_REFERER'] = contact_forms_path
      contact_form = create(:contact_form)
      delete :destroy, :id => contact_form.id
      response.should redirect_to(contact_forms_path)
    end
    it "redirects to the contact_forms list when called from edit page" do
      contact_form = create(:contact_form)
      @request.env['HTTP_REFERER'] = edit_contact_form_path(contact_form)
      delete :destroy, :id => contact_form.id
      response.should redirect_to(contact_forms_path)
    end
  end

end
