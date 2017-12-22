class ReviewsController < ApplicationController

  before_action :authenticate_user!

  before_action :set_review, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.all
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
      params.require(:review).permit(:title, :content, :photo)
    end

    def set_review
      @review = Review.find(params[:id])
    end

end
