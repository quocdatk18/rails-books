# frozen_string_literal: true

# class ApplicationController
class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[user_name email password password_confirmation phone gender]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

  private

  def record_not_found
    render plain: '404 Not Found', status: 404
  end
end
