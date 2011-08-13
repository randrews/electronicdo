class CreateGames < ActiveRecord::Migration
    def self.up
        create_table :games do |t|
            t.integer :goal_words, :default => 10, :null => false
            t.string :name, :null => false
            t.string :password
            t.string :admin_password, :null => false

            t.timestamps
        end
    end

    def self.down
        drop_table :games
    end
end
