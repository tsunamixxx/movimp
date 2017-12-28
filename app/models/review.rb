class Review < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user

  # CommentモデルのAssociationを設定
  has_many :comments, dependent: :destroy

  # 写真投稿
  mount_uploader :photo, PhotoUploader
end
