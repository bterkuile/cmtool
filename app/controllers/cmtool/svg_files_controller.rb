module Cmtool
  class Cmtool::SvgFilesController < Cmtool::ApplicationController
    # GET /svg_files
    # GET /svg_files.xml
    def index
      @svg_files = Cmtool::SvgFile.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @svg_files }
      end
    end

    # GET /svg_files/1
    # GET /svg_files/1.xml
    def show
      @svg_file = Cmtool::SvgFile.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @svg_file }
      end
    end

    # GET /svg_files/new
    # GET /svg_files/new.xml
    def new
      @svg_file = Cmtool::SvgFile.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @svg_file }
      end
    end

    # GET /svg_files/1/edit
    def edit
      @svg_file = Cmtool::SvgFile.find(params[:id])
    end

    # POST /svg_files
    # POST /svg_files.xml
    def create
      @svg_file = Cmtool::SvgFile.new(svg_file_params)

      respond_to do |format|
        if @svg_file.save
          format.html { redirect_to(cmtool.svg_files_path, :notice => I18n.t('cmtool.action.create.successful', :model => Cmtool::SvgFile.model_name.human)) }
          format.xml  { render :xml => @svg_file, :status => :created, :location => @svg_file }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @svg_file.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /svg_files/1
    # PUT /svg_files/1.xml
    def update
      @svg_file = Cmtool::SvgFile.find(params[:id])

      respond_to do |format|
        if @svg_file.update_attributes(svg_file_params)
          format.html { redirect_to(cmtool.svg_files_path, :notice => I18n.t('cmtool.action.update.successful', :model => Cmtool::SvgFile.model_name.human)) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @svg_file.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /svg_files/1
    # DELETE /svg_files/1.xml
    def destroy
      @svg_file = Cmtool::SvgFile.find(params[:id])
      @svg_file.destroy

      respond_to do |format|
        format.html { redirect_to(cmtool.svg_files_url, notice: I18n.t('cmtool.action.destroy.successful', model: Cmtool::SvgFile.model_name.human)) }
        format.xml  { head :ok }
      end
    end

    private

    def svg_file_params
      params.require(:svg_file).permit(:name)
    end
  end
end
