module TurnsHelper

    def turn_title turn
        s = "Pilgrim " + turn.pilgrim.name
        s += (s[-1,1] == 's' ? "'" : "'s")
        s += " turn"
    end

    def stone_images color, turn
        base = turn.id || 0
        files = []
        turn.send("#{color}_stones_drawn").times do |n|
            files << "#{color}_#{(n+base)%3+1}.jpg"
        end
        files
    end

    def options_for_rescue turn
        pilgrims = turn.game.all_troubled_pilgrims.map{|p| ["Pilgrim #{p.name}", p.id]}
        options_for_select([["A worldly person", 0]] + pilgrims)
    end
end
