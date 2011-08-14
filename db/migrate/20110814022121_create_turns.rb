class CreateTurns < ActiveRecord::Migration
  def self.up
    create_table :turns do |t|
      t.integer :game_id, :null => false
      t.integer :pilgrim_id, :null => false # Pilgrim whose turn it is
      t.integer :white_stones_drawn, :null => false
      t.integer :black_stones_drawn, :null => false
      t.integer :color_kept
      t.integer :pilgrim_rescued_id
      t.integer :pilgrim_in_trouble_id
      t.integer :goal_words_used, :default => 0
      t.integer :state, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :turns
  end
end
