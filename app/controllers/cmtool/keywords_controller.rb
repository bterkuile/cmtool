module Cmtool
  class Cmtool::KeywordsController < Cmtool::ApplicationController
    # GET /keywords
    # GET /keywords.xml
    def index
      @keywords = Cmtool::Keyword.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @keywords }
      end
    end

    # GET /keywords/1
    # GET /keywords/1.xml
    def show
      @keyword = Cmtool::Keyword.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @keyword }
      end
    end

    # GET /keywords/new
    # GET /keywords/new.xml
    def new
      @keyword = Cmtool::Keyword.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @keyword }
      end
    end

    # GET /keywords/1/edit
    def edit
      @keyword = Cmtool::Keyword.find(params[:id])
    end

    # POST /keywords
    # POST /keywords.xml
    def create
      @keyword = Cmtool::Keyword.new(keyword_params)

      respond_to do |format|
        if @keyword.save
          format.html { redirect_to(cmtool.keywords_path, :notice => I18n.t('cmtool.action.create.successful', :model => Cmtool::Keyword.model_name.human)) }
          format.xml  { render :xml => @keyword, :status => :created, :location => @keyword }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @keyword.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /keywords/1
    # PUT /keywords/1.xml
    def update
      @keyword = Cmtool::Keyword.find(params[:id])

      respond_to do |format|
        if @keyword.update_attributes(keyword_params)
          format.html { redirect_to(cmtool.keywords_path, :notice => I18n.t('cmtool.action.update.successful', :model => Cmtool::Keyword.model_name.human)) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @keyword.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /keywords/1
    # DELETE /keywords/1.xml
    def destroy
      @keyword = Cmtool::Keyword.find(params[:id])
      @keyword.destroy

      respond_to do |format|
        format.html { redirect_to(cmtool.keywords_url, notice: I18n.t('cmtool.action.destroy.successful', model: Cmtool::Keyword.model_name.human)) }
        format.xml  { head :ok }
      end
    end

    private

    def keyword_params
      params.require(:keyword).permit(:name)
    end
  end
end
