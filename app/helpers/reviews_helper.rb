module ReviewsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm' # ここのconfirmは確認画面にてエラーが発生した場合、正しい入力をした際に確認画面へ飛ぶようにするため。
      confirm_reviews_path
    elsif action_name == 'edit'
      review_path
    end
  end
end
