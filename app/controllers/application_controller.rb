# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, if: :use_auth?
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger

  private

  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end

  def use_auth?
    true unless controller_name == 'tops' || controller_name == 'pages'
  end

  protected

  def configure_permitted_parameters
    # サインアップ時のストロングパラメータ
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    # アカウント編集時のストロングパラメータ
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[username avatar avatar_cache kop_history favorite_player])
  end
end
