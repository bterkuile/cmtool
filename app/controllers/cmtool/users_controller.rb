module Cmtool
  class UsersController < Cmtool::ApplicationController

    # GET /cmtool/users
    def index
      @users = ::User.all
    end

    def show
      @user = ::User.find(params[:id])
    end

    def edit
      @user = ::User.find(params[:id])
    end

    def new
      @user = ::User.new
    end

    def create
      @user = ::User.new(user_params)
      if @user.save
        redirect_to cmtool.users_path, :notice => I18n.t('cmtool.action.create.successful', :model => ::User.model_name.human)
      else
        render :action => 'new'
      end
    end

    def update
      user = user_params
      unless user['password'].present?
        user.delete('password')
        user.delete('password_confirmation')
      end
      @user = ::User.find(params[:id])
      if @user.update_attributes(user)
        if user['password']
          # Sign in after changing current logged in password
          sign_in(@user, :bypass => true) if @user == current_user
        end
        redirect_to cmtool.users_path, :notice => I18n.t('cmtool.action.update.successful', :model => ::User.model_name.human)
      else
        render :action => 'edit'
      end
    end

    def destroy
      @user = ::User.find(params[:id])
      @user.destroy
      redirect_to cmtool.users_path, :notice => I18n.t('cmtool.action.destroy.successful', :model => ::User.model_name.human)
    end

    private

    def user_params
      params.require(:user).permit!
    end
  end
end
