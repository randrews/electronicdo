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

    def kept_stones
        if white_kept? then white_stones_drawn
        elsif black_kept? then black_stones_drawn
        else 0 end
    end

    def troubled
        game.pilgrim_in_trouble? pilgrim
    end

    def pilgrim_may_use_goal_word?
        (!troubled && (kept_stones == 2 || kept_stones == 3)) ||
            (troubled && kept_stones == 0)
    end

    def troublemakers_may_use_goal_word?
        (!troubled && kept_stones != 3) || (troubled && kept_stones == 2)
    end

    def pilgrim_may_rescue?
        (!troubled && (kept_stones == 2 || kept_stones == 3))        
    end

    # A little note about fields:
    # The pilgrim_rescued_id and pilgrim_in_trouble_id are only set if
    # the pilgrim in question actually changes state. Turns where the
    # pilgrim is rescued then put immediately back in trouble (like
    # troubled / 2-stones) won't have either rescued or in_trouble IDs
    # set.
    def handle_rescue_trouble rescued_id = 0
        # We first want to set rescued ID
        if rescued_id.to_i > 0 && pilgrim_may_rescue?
            self.pilgrim_rescued_id = rescued_id.to_i
        end

        # Maybe we'll rescue ourselves
        if troubled && (kept_stones == 1 || kept_stones == 3)
            self.pilgrim_rescued_id = self.pilgrim.id
        end

        # Oops, you got into trouble
        if !troubled && (kept_stones == 0 || kept_stones == 2)
            self.pilgrim_in_trouble_id = self.pilgrim.id
        end
    end

    def summary_string
        "Pilgrim #{pilgrim.name} took #{kept_stones} " +
            (white_kept? ? "white" : "black") + " stone" +
            (kept_stones == 1 ? "" : "s")
    end
end
