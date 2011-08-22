module GamesHelper

    def pilgrim_summary pilgrim
        str = "Pilgrim #{pilgrim.name}"

        stones = pilgrim.game.stones_for_pilgrim(pilgrim)
        troubled = pilgrim.game.pilgrim_in_trouble? pilgrim
        maybe_plural = lambda{|n| (n == 1 ? 'stone' : 'stones')}

        if stones[:black] > 0
            black_str = "#{stones[:black]} black #{maybe_plural[stones[:black]]}"
        end

        if stones[:white] > 0
            white_str = "#{stones[:white]} white #{maybe_plural[stones[:white]]}"
        end

        if stones.values.sum > 0
            if stones[:black] == 0
                str = "#{str} has #{white_str}"
            elsif stones[:white] == 0
                str = "#{str} has #{black_str}"
            else
                str = "#{str} has #{black_str}, #{white_str}"
            end

            str = "#{str} and" if troubled
        end

        str = "#{str} is in trouble" if troubled
        str
    end
end
