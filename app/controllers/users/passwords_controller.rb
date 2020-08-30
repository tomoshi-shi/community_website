# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :require_no_authentication

  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    # 入力チェック
    # スーパークラスでチェックは実行されているがflashに対応していないため独自に実装
    email = params[:user][:email].to_s
    if email !~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      flash[:error] = "メールアドレスが正しくありません"
      redirect_to new_user_password_path
    else
      # 入力チェックに問題がない場合、パスワード再発行処理呼び出し
      super
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    # 入力チェック
    # スーパークラスでチェックは実行されているがflashに対応していないため独自に実装
    password = params[:user][:password].to_s
    password_confirmation = params[:user][:password_confirmation].to_s
    minimum_password_length = params[:user][:minimum_password_length].to_i
    reset_password_token = params[:user][:reset_password_token]
    if password.length < minimum_password_length ||
       password_confirmation.length < minimum_password_length
      flash[:error] = "パスワードを#{minimum_password_length}文字以上で入力してください"
      redirect_to edit_password_url(User.new, reset_password_token: reset_password_token)
      return
    elsif !Devise.secure_compare(password, password_confirmation)
      flash[:error] = "新しいパスワードが一致しません"
      redirect_to edit_password_url(User.new, reset_password_token: reset_password_token)
      return
    else
      # 入力チェックに問題がない場合、パスワード再発行処理実行
      flash[:notice] = "パスワードの再発行を完了しました"
      super
    end
  end

  protected

  def after_resetting_password_path_for(resource)
    puts "after_resetting_password_path_for"
    user_session_path
  end

  The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    puts "after_sending_reset_password_instructions_path_for"
    user_session_path
  end
end
