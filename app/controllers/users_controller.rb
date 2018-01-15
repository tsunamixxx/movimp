class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    # order(created_at: :desc)で新しい投稿順にする
    @reviews = Review.all.order(created_at: :desc)
    @user = User.find(params[:id])
  end

end
