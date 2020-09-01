class Users::Mailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers

  helper :application
  default template_path: 'devise/mailer'

  def reset_password_instructions(record, token, opts={})
    opts[:subject] = "メールアドレスの再設定"

    # 件名以外はdeviseの設定を継承して利用
    super
  end
end
