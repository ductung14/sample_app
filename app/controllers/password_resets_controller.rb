class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: [:edit, :update]
  
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t("pass_reset.info")
      redirect_to root_url
    else
      flash.now[:danger] = t("pass_reset.dranger")
      render "new", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      @user.errors.add(:password, t("pass_reset.error"))
      render "edit", status: :unprocessable_entity
    elsif @user.update(user_params)
      log_in @user
      @user.update(reset_digest: nil)
      flash[:success] = t("pass_reset.success")
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
    return if @user
    
    flash[:error] = t("user.notify")
    redirect_to root_path
  end

  def valid_user
    return if @user && @user.activated? &&
      @user.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t("pass_reset.dranger1")
    redirect_to new_password_reset_url
  end
end
