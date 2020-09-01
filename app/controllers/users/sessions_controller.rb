# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  #prepend_before_filter :require_no_authentication, only: [:new, :create, :destroy]
  skip_before_action :require_no_authentication
  before_action :skip_root_if_has_already_logined, only: [:new]
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  # ログイン処理後の遷移先
  def after_sign_in_path_for(resource)
    information_index_path
  end

  def after_inactive_sign_in_path_for(resource)
    user_session_path
  end

  # ログアウト処理後の遷移先
  def after_sign_out_path_for(resource)
    user_session_path
  end
end
