class ReviewsController < ApplicationController
  # before_action :authenticate_user!

  # ログインしていなくても一覧ページを閲覧することができる
  before_action :authenticate_user!, except: [:index]
  # before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy, :confirm]

  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    # order(created_at: :desc)で新しい投稿順にする
    @reviews = Review.all.order(created_at: :desc)
  end

  # showアククションを定義します。入力フォームと一覧を表示するためインスタンスを2つ生成します。
  def show
    @comment = @review.comments.build
    @comments = @review.comments

    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def new
    if params[:back]
      @review = Review.new(reviews_params)
    else
      @review = Review.new
    end
  end

  def create
    # Review.create(reviews_params)
    @review = Review.new(reviews_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to reviews_path, notice:"投稿しました"
      NoticeMailer.sendmail_review(@review).deliver_now
    else
      render 'new'
    end
  end

  def edit
    # @review = Review.find(params[:id])
  end

  def update
    # @review = Review.find(params[:id])
    if @review.update(reviews_params)
      redirect_to reviews_path, notice: "編集が完了しました"
    else
      render 'edit'
    end
  end

  def destroy
    # @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path, notice:"削除しました"
  end

  def confirm
    @review = Review.new(reviews_params)
    render :new if @review.invalid?
  end


  private
    def reviews_params
      params.require(:review).permit(:movie, :title, :content, :photo, :star)
    end

    def set_review
      @review = Review.find(params[:id])
    end

end
