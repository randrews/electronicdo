class Turn < ActiveRecord::Base
    # Colors
    BLACK = 1
    WHITE = 2

    # States
    DRAWN = 0
    SELECTED = 1
    FINISHED = 2

    belongs_to :game
    belongs_to :pilgrim

    validate :valid_enums
    validates_presence_of :pilgrim

    def valid_enums
        errors.add_to_base "Color must be 1 (black) or 2 (white)" unless [nil, 1, 2].include? color_kept
        errors.add_to_base "State must be 0 (drawn), 1 (selected) or 2 (finished)" unless [0, 1, 2].include? state
    end

    def finished? ; state == FINISHED ; end
    def white_kept? ; color_kept == WHITE ; end
    def black_kept? ; color_kept == BLACK ; end
end
