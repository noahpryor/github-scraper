class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.text :repository_url
      t.datetime :last_created
      t.text :owner_name
      t.datetime :first_created
      t.integer :repo_size
      t.datetime :repository_created
      t.integer :watchers
      t.text :forks
      t.text :last_push
      t.integer :feed_hits
      t.boolean :has_gemfile
      t.text :gemfile_contents
      t.datetime :last_checked

      t.timestamps
    end
  end
end
