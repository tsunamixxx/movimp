class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.text :photo

      t.timestamps null: false
    end
  end
end
