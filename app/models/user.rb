class User < ApplicationRecord
  has_secure_password
  
  has_many :tasks
  has_and_belongs_to_many :projects
  enum role: { admin: 0, user: 1 }

  validates :name, :email, presence: true
end

