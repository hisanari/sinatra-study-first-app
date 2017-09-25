class DeleteColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :data, :string
    remove_column :posts, :time, :string
  end
end
