class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: [:create, :destroy]

  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.turbo_stream
    end
  end

  def destroy
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user, status: :see_other }
      format.turbo_stream
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:followed_id]) if action_name == "create"
    @user = Relationship.find_by(id: params[:id])&.followed if action_name == "destroy"
    return if @user

    flash[:error] = t("user.notify")
    redirect_to root_path
  end
end
