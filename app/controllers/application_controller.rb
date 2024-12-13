class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :cms_pages

  private
  def cms_pages
    Page.all
  end
end
