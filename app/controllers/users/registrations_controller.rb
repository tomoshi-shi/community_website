# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  #skip_before_filter :require_no_authentication
  skip_before_action :require_no_authentication
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    # 入力チェック
    # スーパークラスでチェックは実行されているがflashに対応していないため独自に実装
    email = params[:user][:email].to_s
    password = params[:user][:password].to_s
    password_confirmation = params[:user][:password_confirmation].to_s
    minimum_password_length = params[:user][:minimum_password_length].to_i
    if email !~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      flash[:error] = "メールアドレスが正しくありません"
      redirect_to new_user_registration_path
    elsif password.length < minimum_password_length ||
          password_confirmation.length < minimum_password_length
      flash[:error] = "パスワードを#{minimum_password_length}文字以上で入力して下さい"
      redirect_to new_user_registration_path
    elsif !Devise.secure_compare(password, password_confirmation)
      flash[:error] = "入力されたパスワードが一致しません"
      redirect_to new_user_registration_path
    else
      # 入力チェックに問題がない場合、レコード作成
      super
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # super(resource)
    user_session_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
