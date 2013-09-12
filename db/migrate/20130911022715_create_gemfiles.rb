class CreateGemfiles < ActiveRecord::Migration
  def change
    create_table :gemfiles do |t|
      t.integer :repository_id
      t.text :url
      t.text :contents
      t.datetime :last_checked

      t.timestamps
    end
  end
end
