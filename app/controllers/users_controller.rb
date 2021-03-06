class UsersController < ApplicationController
  before_action :logged_in_user?, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in(@user)
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Edits have been saved successfully"
      redirect_to @user
    else
      render 'edit'
    end

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:danger] = "User has been destroyed"
    redirect_to users_path
  end

  private

  def logged_in_user?
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:danger] = "Not authorized to update this profile"
      redirect_to root_path
    end
  end

  def admin_user
    redirect_to login_path unless current_user.present? && current_user.admin?
  end


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
