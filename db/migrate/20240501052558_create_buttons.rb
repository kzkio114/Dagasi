class CreateButtons < ActiveRecord::Migration[7.1]
  def change
    create_table :buttons do |t|
      t.string :name

      t.timestamps
    end
  end
end
