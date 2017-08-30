class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :movie_id
      t.integer :user_id
      t.string :binary
      t.string :detail
      t.string :comments

      t.timestamps
    end
  end
end
