class User < ApplicationRecord
  has_secure_password
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many :user_memberships
  has_many :memberships, through: :user_memberships
  has_many :friendships
  has_many :fitness_datas
  has_many :friends, through: :friendships
  
  has_many :identities, :dependent => :destroy


  def self.from_omniauth(auth)
    identity = Identity.where(provider: auth.provider, uid: auth.uid).first_or_create do |identity|
      if identity.user == nil
        user = User.new
        user.email = auth.info.email || "#{auth.uid}@#{auth.provider}.generated"
        user.password = Devise.friendly_token[0,20]
      end
      identity.user = user
    end

    identity.access_token = auth['credentials']['token']
    identity.refresh_token = auth['credentials']['refresh_token']
    identity.expires_at = auth['credentials']['expires_at']
    identity.timezone = auth['info']['timezone']
    identity.save
    identity.user
  end

  def identity_for(provider)
    identities.where(provider: provider).first
  end

  def fitbit_client

    fitbit_identity = identities.where(provider: 'fitbit').first

    FitgemOauth2::Client.new(
      token: fitbit_identity.access_token,
      client_id: ENV['FITBIT_CLIENT_ID'],
      client_secret: ENV['FITBIT_CLIENT_SECRET'],
      user_id: fitbit_identity.uid
    )
  end
end
