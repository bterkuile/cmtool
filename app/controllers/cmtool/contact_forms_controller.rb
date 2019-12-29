module Cmtool
  class Cmtool::ContactFormsController < Cmtool::ApplicationController
    skip_before_action :authorize_user, only: :add

    # GET /contact_forms
    # GET /contact_forms.xml
    def index
      @contact_forms = Cmtool::ContactForm.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render xml: @contact_forms }
      end
    end

    # GET /contact_forms/1
    # GET /contact_forms/1.xml
    def show
      @contact_form = Cmtool::ContactForm.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render xml: @contact_form }
      end
    end

    # GET /contact_forms/new
    # GET /contact_forms/new.xml
    def new
      @contact_form = Cmtool::ContactForm.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render xml: @contact_form }
      end
    end

    # GET /contact_forms/1/edit
    def edit
      @contact_form = Cmtool::ContactForm.find(params[:id])
    end

    # POST /contact_forms
    # POST /contact_forms.xml
    def create
      @contact_form = Cmtool::ContactForm.new(contact_form_params)

      respond_to do |format|
        if @contact_form.save
          format.html { redirect_to([cmtool, @contact_form], notice: I18n.t('cmtool.action.create.successful', model: Cmtool::ContactForm.model_name.human)) }
          format.xml  { render xml: @contact_form, status: :created, location: @contact_form }
        else
          format.html { render action: "new" }
          format.xml  { render xml: @contact_form.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /contact_forms/1
    # PUT /contact_forms/1.xml
    def update
      @contact_form = Cmtool::ContactForm.find(params[:id])

      respond_to do |format|
        if @contact_form.update_attributes(contact_form_params)
          format.html { redirect_to([cmtool, @contact_form], notice: I18n.t('cmtool.action.update.successful', model: Cmtool::ContactForm.model_name.human)) }
          format.xml  { head :ok }
        else
          format.html { render action: "edit" }
          format.xml  { render xml: @contact_form.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /contact_forms/1
    # DELETE /contact_forms/1.xml
    def destroy
      @contact_form = Cmtool::ContactForm.find(params[:id])
      @contact_form.destroy

      respond_to do |format|
        format.html { redirect_to(cmtool.contact_forms_url) }
        format.xml  { head :ok }
      end
    end

    def add
      @contact_form = Cmtool::ContactForm.new(contact_form_params)
      if @contact_form.save
        redirect_to :back, notice: I18n.t('cmtool.contact_form.submitted')
      else
        redirect_to :back, alert: I18n.t('cmtool.contact_form.submission_failed', reason: @contact_form.errors.full_messages.to_sentence )
      end
    end

    private

    def contact_form_params
      params.require(:contact_form).permit(:gender, :name, :email, :phone, :body)
    end
  end
end
