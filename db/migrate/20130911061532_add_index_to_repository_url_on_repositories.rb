class AddIndexToRepositoryUrlOnRepositories < ActiveRecord::Migration
  def change
    add_index :repositories, :repository_url
  end
end
