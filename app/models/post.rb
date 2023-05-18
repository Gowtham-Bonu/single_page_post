class Post < ApplicationRecord
  belongs_to :user
  with_options dependent: :destroy do |assoc|
    assoc.has_many :comments
    assoc.has_many :likes
  end

  validates :title, presence: true
end