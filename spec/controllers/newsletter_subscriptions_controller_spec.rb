require 'spec_helper'

describe Cmtool::NewsletterSubscriptionsController do
  before :each do
    sign_in @user
  end

  describe 'no user is signed in' do
    before :each do
      sign_out @user
    end
    it "should not allow acces when no user is logged in" do
      newsletter_subscription = create :newsletter_subscription
      get :index
      response.should be_redirect
    end

    it "should add a subscription without authentication" do
      @request.env['HTTP_REFERER'] = '/'
      expect {
        post :add, newsletter_subscription: {email: "unauthenticated@example.com"}
      }.to change(Cmtool::NewsletterSubscription, :count).by(1)
    end
  end

  describe "GET index" do
    it "assigns all newsletter_subscriptions as @newsletter_subscriptions" do
      newsletter_subscription = create :newsletter_subscription
      get :index
      assigns(:newsletter_subscriptions).should eq([newsletter_subscription])
    end
  end

  describe "GET show" do
    it "assigns the requested newsletter_subscription as @newsletter_subscription" do
      newsletter_subscription = create :newsletter_subscription
      get :show, :id => newsletter_subscription.id
      assigns(:newsletter_subscription).should eq(newsletter_subscription)
    end
  end

  describe "GET new" do
    it "assigns a new newsletter_subscription as @newsletter_subscription" do
      get :new
      assigns(:newsletter_subscription).should be_a_new(Cmtool::NewsletterSubscription)
    end
  end

  describe "GET edit" do
    it "assigns the requested newsletter_subscription as @newsletter_subscription" do
      newsletter_subscription = create :newsletter_subscription
      get :edit, :id => newsletter_subscription.id
      assigns(:newsletter_subscription).should eq(newsletter_subscription)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Cmtool::NewsletterSubscription" do
        expect {
          post :create, :newsletter_subscription => build(:newsletter_subscription).attributes
        }.to change(Cmtool::NewsletterSubscription, :count).by(1)
      end

      it "assigns a newly created newsletter_subscription as @newsletter_subscription" do
        post :create, :newsletter_subscription => build(:newsletter_subscription).attributes
        assigns(:newsletter_subscription).should be_a(Cmtool::NewsletterSubscription)
        assigns(:newsletter_subscription).should be_persisted
      end

      it "redirects to the newsletter_subscriptions newsletter_subscription" do
        post :create, :newsletter_subscription => build(:newsletter_subscription).attributes
        response.should redirect_to(Cmtool::NewsletterSubscription.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved newsletter_subscription as @newsletter_subscription" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cmtool::NewsletterSubscription.any_instance.stub(:save).and_return(false)
        post :create, :newsletter_subscription => {}
        assigns(:newsletter_subscription).should be_a_new(Cmtool::NewsletterSubscription)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cmtool::NewsletterSubscription.any_instance.stub(:save).and_return(false)
        post :create, :newsletter_subscription => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested newsletter_subscription" do
        newsletter_subscription = create(:newsletter_subscription)
        # Assuming there are no other newsletter_subscriptions in the database, this
        # specifies that the Cmtool::NewsletterSubscription created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Cmtool::NewsletterSubscription.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => newsletter_subscription.id, :newsletter_subscription => {'these' => 'params'}
      end

      it "assigns the requested newsletter_subscription as @newsletter_subscription" do
        newsletter_subscription = create(:newsletter_subscription)
        put :update, :id => newsletter_subscription.id, :newsletter_subscription => newsletter_subscription.attributes
        assigns(:newsletter_subscription).should eq(newsletter_subscription)
      end

      it "redirects to the newsletter_subscription" do
        newsletter_subscription = create(:newsletter_subscription)
        put :update, :id => newsletter_subscription.id, :newsletter_subscription => newsletter_subscription.attributes
        response.should redirect_to(newsletter_subscription)
      end
    end

    describe "with invalid params" do
      it "assigns the newsletter_subscription as @newsletter_subscription" do
        newsletter_subscription = create(:newsletter_subscription)
        # Trigger the behavior that occurs when invalid params are submitted
        Cmtool::NewsletterSubscription.any_instance.stub(:save).and_return(false)
        put :update, :id => newsletter_subscription.id, :newsletter_subscription => {}
        assigns(:newsletter_subscription).should eq(newsletter_subscription)
      end

      it "re-renders the 'edit' template" do
        newsletter_subscription = create(:newsletter_subscription)
        # Trigger the behavior that occurs when invalid params are submitted
        Cmtool::NewsletterSubscription.any_instance.stub(:save).and_return(false)
        put :update, :id => newsletter_subscription.id, :newsletter_subscription => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested newsletter_subscription" do
      @request.env['HTTP_REFERER'] = newsletter_subscriptions_path
      newsletter_subscription = create(:newsletter_subscription)
      expect {
        delete :destroy, :id => newsletter_subscription.id
      }.to change(Cmtool::NewsletterSubscription, :count).by(-1)
    end

    it "redirects to the newsletter_subscriptions list" do
      @request.env['HTTP_REFERER'] = newsletter_subscriptions_path
      newsletter_subscription = create(:newsletter_subscription)
      delete :destroy, :id => newsletter_subscription.id
      response.should redirect_to(newsletter_subscriptions_path)
    end
    it "redirects to the newsletter_subscriptions list when called from edit page" do
      newsletter_subscription = create(:newsletter_subscription)
      @request.env['HTTP_REFERER'] = edit_newsletter_subscription_path(newsletter_subscription)
      delete :destroy, :id => newsletter_subscription.id
      response.should redirect_to(newsletter_subscriptions_path)
    end
  end

end
