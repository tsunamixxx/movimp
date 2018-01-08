class AddStarToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :star, :integer
  end
end
