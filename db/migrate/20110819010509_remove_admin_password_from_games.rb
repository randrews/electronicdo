class RemoveAdminPasswordFromGames < ActiveRecord::Migration
  def self.up
      remove_column :games, :admin_password
  end

  def self.down
      # Column is gone; can't get it back
      raise ActiveRecord::IrreversibleMigration
  end
end
