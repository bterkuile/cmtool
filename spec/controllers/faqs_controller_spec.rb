require 'spec_helper'

describe Cmtool::FaqsController, type: :controller do
  routes { Cmtool::Engine.routes }
  before :each do
    sign_in @user
  end

  describe 'no user is signed in' do
    before :each do
      sign_out @user
    end
    it "should not allow acces when no user is logged in" do
      faq = create :faq
      get :index
      response.should be_redirect
    end
  end

  describe "GET index" do
    it "assigns all faqs as @faqs" do
      faq = create :faq
      get :index
      assigns(:faqs).should eq([faq])
    end
  end

  describe "GET show" do
    it "assigns the requested faq as @faq" do
      faq = create :faq
      get :show, :id => faq.id
      assigns(:faq).should eq(faq)
    end
  end

  describe "GET new" do
    it "assigns a new faq as @faq" do
      get :new
      assigns(:faq).should be_a_new(Cmtool::Faq)
    end
  end

  describe "GET edit" do
    it "assigns the requested faq as @faq" do
      faq = create :faq
      get :edit, :id => faq.id
      assigns(:faq).should eq(faq)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Cmtool::Faq" do
        expect {
          post :create, :faq => build(:faq).attributes
        }.to change(Cmtool::Faq, :count).by(1)
      end

      it "assigns a newly created faq as @faq" do
        post :create, :faq => build(:faq).attributes
        assigns(:faq).should be_a(Cmtool::Faq)
        assigns(:faq).should be_persisted
      end

      it "redirects to the faqs faq" do
        post :create, :faq => build(:faq).attributes
        response.should redirect_to(Cmtool::Faq.last)
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested faq" do
        faq = create(:faq)
        # Assuming there are no other faqs in the database, this
        # specifies that the Cmtool::Faq created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of( Cmtool::Faq ).to receive(:update_attributes).with({'question' => 'meaning of life'})
        put :update, :id => faq.id, :faq => {'question' => 'meaning of life'}
      end

      it "assigns the requested faq as @faq" do
        faq = create(:faq)
        put :update, :id => faq.id, :faq => faq.attributes
        assigns(:faq).should eq(faq)
      end

      it "redirects to the faq" do
        faq = create(:faq)
        put :update, :id => faq.id, :faq => faq.attributes
        response.should redirect_to(faq)
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested faq" do
      @request.env['HTTP_REFERER'] = faqs_path
      faq = create(:faq)
      expect {
        delete :destroy, :id => faq.id
      }.to change(Cmtool::Faq, :count).by(-1)
    end

    it "redirects to the faqs list" do
      @request.env['HTTP_REFERER'] = faqs_path
      faq = create(:faq)
      delete :destroy, :id => faq.id
      response.should redirect_to(faqs_path)
    end
    it "redirects to the faqs list when called from edit page" do
      faq = create(:faq)
      @request.env['HTTP_REFERER'] = edit_faq_path(faq)
      delete :destroy, :id => faq.id
      response.should redirect_to(faqs_path)
    end
  end

end
