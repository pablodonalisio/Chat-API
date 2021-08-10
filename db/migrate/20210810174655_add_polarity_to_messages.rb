class AddPolarityToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :polarity, :string
  end
end
