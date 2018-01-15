class Users::RegistrationsController < Devise::RegistrationsController
  # def build_resource(hash=nil)
  # 本番環境(heroku)のアカウント登録ページへアクセスした際に500errorが出た場合は、上記の(hash=nil)を(hash={})に書き換えるとerrorがなくなる
  def build_resource(hash={})
    hash[:uid] = User.create_unique_string
    super
  end
end
