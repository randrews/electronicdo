class Game < ActiveRecord::Base
    has_many :pilgrims
    accepts_nested_attributes_for(:pilgrims,
                                  :reject_if => lambda{|p| p[:name].blank? },
                                  :limit => 5)

    validate :pilgrim_count, :pilgrim_names
    validates_presence_of :name, :goal_words
    validates_uniqueness_of :name
    validates_numericality_of :goal_words

    has_many :turns, :order => "created_at"

    def pilgrim_count
        s = self.pilgrims.size
        errors.add_to_base "Must have between 3 and 5 pilgrims" unless s>=3 && s<=5
    end

    def pilgrim_names
        n = self.pilgrims.map &:name
        errors.add_to_base "Pilgrim names must be unique" unless n.size == n.uniq.size
    end

    def last_activity
        turns.last && turns.last.updated_at
    end

    def can_start_turn?
        turns.blank? || turns.last.finished?
    end

    def storyteller
        idx = Turn.find(:all, :conditions => {:state => Turn::FINISHED, :game_id => id}).count % pilgrims.size
        pilgrims[idx]
    end

    def create_turn
        raise "A turn is already in progress" unless can_start_turn?
        t = turns.new :pilgrim => storyteller
        t.white_stones_drawn, t.black_stones_drawn = three_random_stones
        t.save
        t
    end

    def white_stones_left
        drawn = turns.select{|t| t.white_kept? }.map(&:white_stones_drawn).sum || 0
        20 - (drawn % 20)
    end

    def black_stones_left
        drawn = turns.select{|t| t.black_kept? }.map(&:black_stones_drawn).sum || 0
        20 - (drawn % 20)
    end

    # Returns two values: the number of white stones drawn and the number of black stones drawn
    def three_random_stones
        bag = [Turn::BLACK]*black_stones_left + [Turn::WHITE]*white_stones_left
        draw = bag.shuffle[0..2]
        w = draw.count(Turn::WHITE)
        b = draw.count(Turn::BLACK)

        return w, b
    end

    def latest_turn
        turns.last
    end

    def finished_turns
        turns.select{|t| t.state == Turn::FINISHED }
    end

    def pilgrim_in_trouble? pilgrim
        last_relevant_turn = turns.select{|t|
            t.pilgrim_in_trouble_id == pilgrim.id ||
            t.pilgrim_rescued_id == pilgrim.id }.last

        last_relevant_turn && last_relevant_turn.pilgrim_in_trouble_id == pilgrim.id
    end

    def all_troubled_pilgrims
        pilgrims.select{|p| pilgrim_in_trouble? p}
    end

    def stones_for_pilgrim pilgrim
        relevant_turns = turns.select{|t| t.pilgrim == pilgrim }
        white_total = relevant_turns.select{|t|
            t.color_kept == Turn::WHITE }.map{|t|
            t.white_stones_drawn }.sum

        black_total = relevant_turns.select{|t|
            t.color_kept == Turn::BLACK }.map{|t|
            t.black_stones_drawn }.sum

        {:black => black_total, :white => white_total}
    end
end
