class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :short_desc
      t.integer :genre_id
      t.integer :writer_id

      t.timestamps null: false
    end
  end
end
