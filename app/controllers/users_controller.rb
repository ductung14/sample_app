class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    return if @user
  
    flash[:error] = t("home.notify")
    redirect_to root_path
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t("home.greeting")
      redirect_to @user
    else
      flash[:error] = t("home.error")
      render "new", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
