module ApplicationHelper
  include Pagy::Frontend
  def full_title page_title = ""
    base_title = t("application.title")
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
