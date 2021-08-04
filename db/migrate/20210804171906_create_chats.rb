class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.integer :user_1_id, null: false
      t.integer :user_2_id, null: false

      t.timestamps
    end
  end
end
