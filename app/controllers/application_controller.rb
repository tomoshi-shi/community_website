class ApplicationController < ActionController::Base

  # すでにログインしている場合、ログイン後のトップページへリダイレクト
  def skip_root_if_has_already_logined
    if current_user.present?
      redirect_to information_index_path
    end
  end

  # 管理者としてログインしていない場合、ログインページへリダイレクト
  def redirect_root_if_not_login_as_admin
    # TODO: メソッド実装
  end

  # どこのページからリクエストが来たか保存しておく
  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    # 現在のURLを保存しておく
    session[:request_from] = request.original_url
  end
end
