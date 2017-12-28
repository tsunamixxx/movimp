class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  # コメントを保存、投稿するためのアクションです。
  def create
    # Reviewをパラメータの値から探し出し,Reviewに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @review = @comment.review
    @notification = @comment.notifications.build(user_id: @review.user.id )
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to review_path(@review), notice: 'コメントを投稿しました。' }
        # JS形式でレスポンスを返します。
        format.js { render :index }

        # pusherの設定。自分の投稿にコメントした場合は通知しない。
        unless @comment.review.user_id == current_user.id
          Pusher.trigger("user_#{@comment.review.user_id}_channel", 'comment_created', {
            message: 'あなたの作成したレビューにコメントが付きました'
          })
        end
        # ヘッダーの通知件数がリアルタイムで更新されるようにする
        Pusher.trigger("user_#{@comment.review.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.review.user.id, read: false).count
        })
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
