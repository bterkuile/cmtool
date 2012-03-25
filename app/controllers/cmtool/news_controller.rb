module Cmtool
  class Cmtool::NewsController < Cmtool::ApplicationController
    # GET /news
    # GET /news.xml
    def index
      @news = Cmtool::News.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @news }
      end
    end

    # GET /news/1
    # GET /news/1.xml
    def show
      @news = Cmtool::News.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @news }
      end
    end

    # GET /news/new
    # GET /news/new.xml
    def new
      @news = Cmtool::News.new :date => Date.today

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @news }
      end
    end

    # GET /news/1/edit
    def edit
      @news = Cmtool::News.find(params[:id])
    end

    # POST /news
    # POST /news.xml
    def create
      @news = Cmtool::News.new(params[:news])

      respond_to do |format|
        if @news.save
          format.html { redirect_to([cmtool, @news], :notice => t('cmtool.action.create.successful', :model => Cmtool::News.model_name.human)) }
          format.xml  { render :xml => @news, :status => :created, :location => @news }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /news/1
    # PUT /news/1.xml
    def update
      @news = Cmtool::News.find(params[:id])

      respond_to do |format|
        if @news.update_attributes(params[:news])
          format.html { redirect_to([cmtool, @news], :notice => t('cmtool.action.update.successful', :model => Cmtool::News.model_name.human)) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /news/1
    # DELETE /news/1.xml
    def destroy
      @news = Cmtool::News.find(params[:id])
      @news.destroy

      respond_to do |format|
        format.html { redirect_to(cmtool.news_index_url) }
        format.xml  { head :ok }
      end
    end

    def remove_image
      @news = Cmtool::News.find(params[:id])
      @news.image = nil
      @news.save
    end
  end
end
