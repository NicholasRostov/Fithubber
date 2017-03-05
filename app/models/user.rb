class User < ApplicationRecord
  has_secure_password
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many :user_memberships
  has_many :memberships, through: :user_memberships
  has_many :friendships
  has_many :fitness_datas
  has_many :friends, through: :friendships
  has_one :fit_user
  
end
