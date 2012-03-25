module Cmtool
  class Cmtool::NewsletterSubscriptionsController < Cmtool::ApplicationController
    # GET /newsletter_subscriptions
    # GET /newsletter_subscriptions.xml
    def index
      @newsletter_subscriptions = Cmtool::NewsletterSubscription.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @newsletter_subscriptions }
      end
    end

    # GET /newsletter_subscriptions/1
    # GET /newsletter_subscriptions/1.xml
    def show
      @newsletter_subscription = Cmtool::NewsletterSubscription.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @newsletter_subscription }
      end
    end

    # GET /newsletter_subscriptions/new
    # GET /newsletter_subscriptions/new.xml
    def new
      @newsletter_subscription = Cmtool::NewsletterSubscription.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @newsletter_subscription }
      end
    end

    # GET /newsletter_subscriptions/1/edit
    def edit
      @newsletter_subscription = Cmtool::NewsletterSubscription.find(params[:id])
    end

    # POST /newsletter_subscriptions
    # POST /newsletter_subscriptions.xml
    def create
      @newsletter_subscription = Cmtool::NewsletterSubscription.new(params[:newsletter_subscription])

      respond_to do |format|
        if @newsletter_subscription.save
          format.html { redirect_to([cmtool, @newsletter_subscription], :notice => I18n.t('cmtool.action.create.successful', :model => Cmtool::NewsletterSubscription.model_name.human)) }
          format.xml  { render :xml => @newsletter_subscription, :status => :created, :location => @newsletter_subscription }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @newsletter_subscription.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /newsletter_subscriptions/1
    # PUT /newsletter_subscriptions/1.xml
    def update
      @newsletter_subscription = Cmtool::NewsletterSubscription.find(params[:id])

      respond_to do |format|
        if @newsletter_subscription.update_attributes(params[:newsletter_subscription])
          format.html { redirect_to([cmtool, @newsletter_subscription], :notice => I18n.t('cmtool.action.update.successful', :model => Cmtool::NewsletterSubscription.model_name.human)) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @newsletter_subscription.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /newsletter_subscriptions/1
    # DELETE /newsletter_subscriptions/1.xml
    def destroy
      @newsletter_subscription = Cmtool::NewsletterSubscription.find(params[:id])
      @newsletter_subscription.destroy

      respond_to do |format|
        format.html { redirect_to(cmtool.newsletter_subscriptions_url) }
        format.xml  { head :ok }
      end
    end
  end
end
