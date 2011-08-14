class Game < ActiveRecord::Base
    has_many :pilgrims
    accepts_nested_attributes_for(:pilgrims,
                                  :reject_if => lambda{|p| p[:name].blank? },
                                  :limit => 5)

    validate :pilgrim_count, :pilgrim_names

    has_many :turns

    def pilgrim_count
        s = self.pilgrims.size
        errors.add_to_base "Must have between 3 and 5 pilgrims" unless s>=3 && s<=5
    end

    def pilgrim_names
        n = self.pilgrims.map &:name
        errors.add_to_base "Pilgrim names must be unique" unless n.size == n.uniq.size
    end
end
