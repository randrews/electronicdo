class CreatePilgrims < ActiveRecord::Migration
  def self.up
    create_table :pilgrims do |t|
      t.string :name, :null => false
      t.integer :game_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :pilgrims
  end
end
