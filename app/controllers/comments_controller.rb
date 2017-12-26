class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  # コメントを保存、投稿するためのアクションです。
  def create
    # Reviewをパラメータの値から探し出し,Reviewに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @review = @comment.review
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to review_path(@review), notice: 'コメントを投稿しました。' }
        # JS形式でレスポンスを返します。
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    #@comment = Comment.find(params[:id])
    @review = @comment.review
  end

  def update
    # @comment = Comment.find(params[:id])
    @review = @comment.review
    if @comment.update(comment_params)
      redirect_to review_path(@review), notice: "コメントを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    # @comment = Comment.find(params[:id])
    @comment.destroy
    @review = @comment.review
    redirect_to review_path(@review), notice: "コメントを削除しました！"
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:review_id, :content)
    end
    def set_comment
      @comment = Comment.find(params[:id])
    end
end
