class MicropostsController < ApplicationController
  include Pagy::Backend
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :authorize_micropost, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = t("micropost.success")
      redirect_to root_url
    else
      @pagy, @feed_items = pagy(current_user.feed, page: params[:page], items: Settings.items_per_page)
      render "static_pages/home", status: :unprocessable_entity
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t("micropost.success")
      redirect_to request.referrer || root_url, status: :see_other
    else
      flash[:error] = t("micropost.error")
      redirect_to root_url
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def authorize_micropost
    @micropost = current_user.microposts.find_by(id: params[:id])
    return if @micropost
    
    flash[:error] = t("micropost.error1")
    redirect_to root_url, status: :see_other
  end
end
