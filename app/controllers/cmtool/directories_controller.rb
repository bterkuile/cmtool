module Cmtool
  class DirectoriesController < Cmtool::ApplicationController
    # GET /directories
    # GET /directories.xml
    def index
      @directories = Cmtool::Directory.roots

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @directories }
      end
    end

    # GET /directories/1
    # GET /directories/1.xml
    def show
      @directory = Cmtool::Directory.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @directory }
      end
    end

    # GET /directories/new
    # GET /directories/new.xml
    def new
      @directory = Cmtool::Directory.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @directory }
      end
    end

    # GET /directories/1/edit
    def edit
      @directory = Cmtool::Directory.find(params[:id])
    end

    # POST /directories
    # POST /directories.xml
    def create
      @directory = Cmtool::Directory.new(params[:directory])

      respond_to do |format|
        if @directory.save
          format.html { redirect_to([cmtool, @directory], :notice => I18n.t('cmtool.action.create.successful', :model => Cmtool::Directory.model_name.human)) }
          format.xml  { render :xml => @directory, :status => :created, :location => @directory }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @directory.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /directories/1
    # PUT /directories/1.xml
    def update
      @directory = Cmtool::Directory.find(params[:id])

      respond_to do |format|
        if @directory.update_attributes(params[:directory])
          format.html { redirect_to([cmtool, @directory], :notice => I18n.t('cmtool.action.update.successful', :model => Cmtool::Directory.model_name.human)) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @directory.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /directories/1
    # DELETE /directories/1.xml
    def destroy
      @directory = Cmtool::Directory.find(params[:id])
      @directory.destroy
      flash[:notice] = I18n.t('cmtool.action.destroy.successful', :model => Cmtool::Directory.model_name.human)
      respond_to do |format|
        format.html { redirect_to(cmtool.directories_url) }
        format.xml  { head :ok }
      end
    end
    def remove_image
      @directory = Cmtool::Directory.find(params[:id])
      @directory.image = nil
      @directory.save
    end
  end
end
