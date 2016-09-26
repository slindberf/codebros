class RemoveAvatarOfProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :avatar_file_name, :string
    remove_column :projects, :avatar_content_type, :string
    remove_column :projects, :avatar_file_size, :string
    remove_column :projects, :avatar_updated_at, :datetime
  end
end
