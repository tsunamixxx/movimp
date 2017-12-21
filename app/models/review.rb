class Review < ActiveRecord::Base
  validates :title, presence: true
end
