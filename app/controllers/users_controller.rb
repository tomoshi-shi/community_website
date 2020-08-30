class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @user = current_user
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    user = current_user

    # 変数設定
    # スーパークラスでチェックは実行されているがflashに対応していないため独自に実装
    email = params[:user][:email].to_s
    last_name = params[:user][:last_name].to_s
    first_name = params[:user][:first_name].to_s
    last_name_initial = params[:user][:last_name_initial].to_s
    first_name_initial = params[:user][:first_name_initial].to_s
    current_password = params[:user][:current_password].to_s
    password = params[:user][:password].to_s
    password_confirmation = params[:user][:password_confirmation].to_s
    minimum_password_length = 6

    # パスワード以外入力チェック
    if last_name_initial.present? && last_name_initial !~ /^[ぁ-ん]+$/
      flash[:error] = "姓かなはひらがなで入力してください"
      redirect_to users_path and return
    end
    if first_name_initial.present? && first_name_initial !~ /^[ぁ-ん]+$/
      flash[:error] = "名かなはひらがなで入力してください"
      redirect_to users_path and return
    end

    # パスワード以外更新
    user.email = email
    user.last_name = last_name
    user.first_name = first_name
    user.last_name_initial = last_name_initial
    user.first_name_initial = first_name_initial

    # パスワード関連入力チェック・更新
    if password.present? || password_confirmation.present? || password_confirmation.present?
      if current_password.length < minimum_password_length ||
        password.length < minimum_password_length ||
        password_confirmation.length < minimum_password_length
        flash[:error] = "パスワードを#{minimum_password_length}文字以上で入力してください"
        redirect_to users_path
        return
      elsif !current_user.valid_password?(current_password)
        flash[:error] = "現在のパスワードを正しく入力してください"
        redirect_to users_path
        return
      elsif !Devise.secure_compare(password, password_confirmation)
        flash[:error] = "新しいパスワードが一致しません"
        redirect_to users_path
        return
      end

      user.password = password
    end

    # 更新処理実行
    if user.save
      # パスワード変更後自動的にログアウトされることを防ぐ
      sign_in(current_user, bypass: true)
      flash[:notice] = "アカウント情報を変更しました"
      redirect_to users_path
      return
    else
      flash[:error] = "アカウント情報の変更に失敗しました"
      redirect_to users_path
      return
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
