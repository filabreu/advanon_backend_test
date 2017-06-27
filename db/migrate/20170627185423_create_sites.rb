class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.belongs_to :site, foreign_key: true
      t.string :type
      t.string :title
      t.string :url
      t.string :url_short

      t.timestamps
    end
  end
end
