class UsersController < ApplicationController
  before_action :load_user, except: [:index, :edit, :update]

  def new
    @user = User.new
  end

  def create
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: "Hello, #{@user.name}"
    else
       flash.alert = "Please fix the errors below to continue."
       render :new
    end
  end

  def show
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def edit
    if !current_user
      redirect_to root_path
    else
      @user = current_user
    end
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to user_path(@user)
      flash.notice = "Your profile has been updated!"
    else
      flash.alert = "Please fix the erros below to sumbit your updated profile"
      render :edit
    end
  end


  protected

  def load_user
    if params[:id].present?
      @user = User.find(params[:id])
    else
      @user = User.new
    end
    if params[:user].present?
      @user.assign_attributes(user_params)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :employment_status, :password, :password_confirmation)
  end

end
