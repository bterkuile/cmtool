module Cmtool
  class PagesController < Cmtool::ApplicationController
    # GET /pages
    # GET /pages.xml
    def index
      #@pages = ::Page.all.sort_by{|p| "#{p.parent.presence.try(:reverse) || p.name}#{p.position.to_s.rjust(6, "0")}" }

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @pages }
      end
    end

    # GET /pages/1
    # GET /pages/1.xml
    def show
      @page = ::Page.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @page }
      end
    end

    # GET /pages/new
    # GET /pages/new.xml
    def new
      @page = ::Page.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @page }
      end
    end

    # GET /pages/1/edit
    def edit
      @page = ::Page.find(params[:id])
    end

    # POST /pages
    # POST /pages.xml
    def create
      @page = ::Page.new(params[:page])

      respond_to do |format|
        if @page.save
          format.html { redirect_to(cmtool.pages_path, :notice => I18n.t('cmtool.action.create.successful', :model => ::Page.model_name.human)) }
          format.xml  { render :xml => @page, :status => :created, :location => @page }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /pages/1
    # PUT /pages/1.xml
    def update
      @page = ::Page.find(params[:id])

      respond_to do |format|
        if @page.update_attributes(params[:page])
          format.html { redirect_to(cmtool.pages_path, :notice => I18n.t('cmtool.action.update.successful', :model => ::Page.model_name.human)) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /pages/1
    # DELETE /pages/1.xml
    def destroy
      @page = ::Page.find(params[:id])
      @page.destroy

      respond_to do |format|
        format.html { redirect_to(cmtool.pages_path) }
        format.xml  { head :ok }
      end
    end
    def generate_name
      @page = ::Page.find(params[:id]) if params[:id]
      render(:js => "alert('Wel eerst een titel invullen')") and return if params[:name].blank?
      # Strategy, 
      # make name lowercase
      # strip all non word charachters from front and end
      # then replace non word characters with a dash
      @generated_name = ::Page.generate_name(params[:name])
      @has_template = @page && @page.name != @generated_name ? template_exists?("pages/#{@page.name}") : nil
    end

    def preview

    end


  end
end
