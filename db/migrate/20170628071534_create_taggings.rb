class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.belongs_to :tag, foreign_key: true
      t.integer :bookmark_id

      t.timestamps
    end
  end
end
