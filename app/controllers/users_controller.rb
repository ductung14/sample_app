class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :load_user, only: [:edit, :show, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy(User.activated, items: Settings.items_per_page)
  end

  def show
    @pagy, @microposts = pagy(@user.microposts, page: params[:page], items: Settings.items_per_page)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = t("user.info")
      redirect_to root_url
    else
      flash[:error] = t("home.error")
      render "new", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = t("user.notify1")
      redirect_to @user
    else
      flash[:error] = t("user.error")
      render "edit", status: :unprocessable_entity
    end
  end  

  def destroy
    if @user.destroy
      flash[:success] = t("user.notify2")
      redirect_to users_url, status: :see_other
    else
      flash[:error] = t("user.error1")
      redirect_to users_url
    end
  end

  private

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user
    
    flash[:error] = t("user.notify")
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def logged_in_user
    return if logged_in?
    
    store_location
    flash[:danger] = t("login.notify")
    redirect_to login_url, status: :see_other
  end

  def correct_user
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end
