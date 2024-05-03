class AddNameAndCategoryToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :name, :string
    add_column :items, :category, :string
  end
end
