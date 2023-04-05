class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  enum :like, [:liked, :dis_liked]
end
