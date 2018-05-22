class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def is_admin?
    user_signed_in? ? current_user.admin == 1 : false
  end

  def after_sign_in_path_for resource
    if resource.is_a? User
      if resource.admin == 1
        admin_root_path
      else
        root_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :address, :phone, :admin]
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
