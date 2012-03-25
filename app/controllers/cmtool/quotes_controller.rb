module Cmtool
  class Cmtool::QuotesController < Cmtool::ApplicationController
    # GET /quotes
    # GET /quotes.xml
    def index
      @quotes = Cmtool::Quote.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @quotes }
      end
    end

    # GET /quotes/1
    # GET /quotes/1.xml
    def show
      @quote = Cmtool::Quote.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @quote }
      end
    end

    # GET /quotes/new
    # GET /quotes/new.xml
    def new
      @quote = Cmtool::Quote.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @quote }
      end
    end

    # GET /quotes/1/edit
    def edit
      @quote = Cmtool::Quote.find(params[:id])
    end

    # POST /quotes
    # POST /quotes.xml
    def create
      @quote = Cmtool::Quote.new(params[:quote])

      respond_to do |format|
        if @quote.save
          format.html { redirect_to([cmtool, @quote], :notice => I18n.t('cmtool.action.create.successful', :model => Cmtool::Quote.model_name.human)) }
          format.xml  { render :xml => @quote, :status => :created, :location => @quote }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @quote.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /quotes/1
    # PUT /quotes/1.xml
    def update
      @quote = Cmtool::Quote.find(params[:id])

      respond_to do |format|
        if @quote.update_attributes(params[:quote])
          format.html { redirect_to([cmtool, @quote], :notice => I18n.t('cmtool.action.update.successful', :model => Cmtool::Quote.model_name.human)) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @quote.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /quotes/1
    # DELETE /quotes/1.xml
    def destroy
      @quote = Cmtool::Quote.find(params[:id])
      @quote.destroy

      respond_to do |format|
        format.html { redirect_to(cmtool.quotes_url, notice: I18n.t('cmtool.action.destroy.successful', model: Cmtool::Quote.model_name.human)) }
        format.xml  { head :ok }
      end
    end
    def remove_image
      @quote = Cmtool::Quote.find(params[:id])
      @quote.image = nil
      @quote.save
    end
  end
end
