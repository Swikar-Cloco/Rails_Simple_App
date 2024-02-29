class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description

      t.timestamps

      # change_table :categories do |t|
      #   t.string :new_column
      # end
    end
  end
end
