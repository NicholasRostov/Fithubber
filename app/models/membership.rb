class Membership < ApplicationRecord
  has_many :user_memberships
  has_many :users, through: :user_memberships
end
