module Cmtool
  class Cmtool::YmlFilesController < Cmtool::ApplicationController
    # GET /yml_files
    # GET /yml_files.xml
    def index
      @yml_files = Cmtool::YmlFile.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @yml_files }
      end
    end

    # GET /yml_files/1
    # GET /yml_files/1.xml
    def show
      @yml_file = Cmtool::YmlFile.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @yml_file }
      end
    end

    # GET /yml_files/new
    # GET /yml_files/new.xml
    def new
      @yml_file = Cmtool::YmlFile.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @yml_file }
      end
    end

    # GET /yml_files/1/edit
    def edit
      @yml_file = Cmtool::YmlFile.find(params[:id])
    end

    # POST /yml_files
    # POST /yml_files.xml
    def create
      @yml_file = Cmtool::YmlFile.new(yml_file_params)

      respond_to do |format|
        if @yml_file.save
          format.html { redirect_to(cmtool.yml_files_path, :notice => I18n.t('cmtool.action.create.successful', :model => Cmtool::YmlFile.model_name.human)) }
          format.xml  { render :xml => @yml_file, :status => :created, :location => @yml_file }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @yml_file.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /yml_files/1
    # PUT /yml_files/1.xml
    def update
      @yml_file = Cmtool::YmlFile.find(params[:id])

      respond_to do |format|
        if @yml_file.update_attributes(yml_file_params)
          format.html { redirect_to(cmtool.yml_files_path, :notice => I18n.t('cmtool.action.update.successful', :model => Cmtool::YmlFile.model_name.human)) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @yml_file.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /yml_files/1
    # DELETE /yml_files/1.xml
    def destroy
      @yml_file = Cmtool::YmlFile.find(params[:id])
      @yml_file.destroy

      respond_to do |format|
        format.html { redirect_to(cmtool.yml_files_url, notice: I18n.t('cmtool.action.destroy.successful', model: Cmtool::YmlFile.model_name.human)) }
        format.xml  { head :ok }
      end
    end

    private

    def yml_file_params
      params.require(:yml_file).permit!
    end
  end
end
