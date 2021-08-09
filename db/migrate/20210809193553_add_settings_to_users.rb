class AddSettingsToUsers < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE chat_settings AS ENUM ('all_upcase', 'all_downcase', 'no_accent_marks');
    SQL
    add_column :users, :settings, :chat_settings
  end

  def down
    remove_column :users, :settings
    execute <<-SQL
      DROP TYPE chat_settings;
    SQL
  end
end
