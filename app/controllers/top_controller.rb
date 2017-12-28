class TopController < ApplicationController
  def index
    # order(created_at: :desc)で新しい投稿順にする
    @reviews = Review.all.order(created_at: :desc)
  end
end
