class AddEmailToTheUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email, :text
  end
end
