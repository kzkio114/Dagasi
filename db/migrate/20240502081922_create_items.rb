class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :keyword

      t.timestamps
    end
  end
end
