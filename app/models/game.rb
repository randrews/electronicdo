class Game < ActiveRecord::Base
    before_create :setup_stones

    def setup_stones black=20, white=20
        self.black_stones = black
        self.white_stones = white
    end
end
