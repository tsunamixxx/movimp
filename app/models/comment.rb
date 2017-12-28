class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
  has_many :notifications, dependent: :destroy
end
