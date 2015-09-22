class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id, null: false
      t.string :body, null: false
      t.timestamps null: false
    end
    add_index :tweets, [:user_id, :created_at]
  end
end
