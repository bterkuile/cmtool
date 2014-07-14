module Cmtool
  class Cmtool::ImagesController < Cmtool::ApplicationController
    # GET /images
    # GET /images.xml
    def index
      @images = Cmtool::Image.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @images }
        format.js
      end
    end

    # GET /images/1
    # GET /images/1.xml
    def show
      @image = Cmtool::Image.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @image }
      end
    end

    # GET /images/new
    # GET /images/new.xml
    def new
      @image = Cmtool::Image.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @image }
      end
    end

    # GET /images/1/edit
    def edit
      @image = Cmtool::Image.find(params[:id])
    end

    # POST /images
    # POST /images.xml
    def create
      @image = Cmtool::Image.new(image_params)

      respond_to do |format|
        if @image.save
          format.html { redirect_to([cmtool, @image.directory || @image], :notice => I18n.t('cmtool.action.create.successful', :model => Cmtool::Image.model_name.human) ) }
          format.xml  { render :xml => @image, :status => :created, :location => @image }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /images/1
    # PUT /images/1.xml
    def update
      @image = Cmtool::Image.find(params[:id])

      respond_to do |format|
        if @image.update_attributes(image_params)
          format.html { redirect_to([cmtool, @image], :notice => I18n.t('cmtool.action.update.successful', :model => Cmtool::Image.model_name.human)) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /images/1
    # DELETE /images/1.xml
    def destroy
      @image = Cmtool::Image.find(params[:id])
      @image.destroy

      respond_to do |format|
        format.html { redirect_to(cmtool.images_url) }
        format.xml  { head :ok }
      end
    end

    def image_params
      params.require(:image).permit(:file, :directory_id)
    end
  end
end
