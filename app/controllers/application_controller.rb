class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  before_action :set_locale

  private

  def hello
    render html: "hello, world!"
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
      locale : I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t("controller.dranger")
    redirect_to login_url, status: :see_other
  end
end
