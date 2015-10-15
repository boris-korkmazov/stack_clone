class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :authorizations

  has_many :questions

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first
    unless user
      password = Devise.friendly_token
      user = User.create!(email: email, password: password, password_confirmation:password)
    end

    user.authorizations.create(provider: auth.provider, uid: auth.uid.to_s)
    user
  end

  def self.send_daily_digest
    find_each do |user|
      DailyMailer.delay.digest(user)
    end
  end


end
