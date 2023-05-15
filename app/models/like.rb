class Like < ApplicationRecord
  enum :status, [:liked, :disliked]
end
