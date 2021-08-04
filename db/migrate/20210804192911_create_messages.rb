class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true
      t.boolean :modified, default: false
      t.boolean :censored, default: false
      t.boolean :is_deleted, default: false

      t.timestamps
    end
  end
end
