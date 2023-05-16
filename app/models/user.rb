class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options dependent: :destroy do |assoc|
    assoc.has_many :posts
    assoc.has_many :likes
    assoc.has_many :comments
  end
end