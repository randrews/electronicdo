class TurnsController < ApplicationController
    before_filter :check_game_password

    def check_game_password
        @password = password_valid_for? params[:game_id]
    end

    # GET /games/:game_id/turns/:id
    def show
        @turn = Turn.find(params[:id])
        @game = @turn.game
        @troubled = @game.pilgrim_in_trouble?(@turn.pilgrim)
    end

    def choose
        @turn = Turn.find(params[:turn_id])
        @game = @turn.game

        if @turn.state == Turn::DRAWN
            @turn.state = Turn::SELECTED
            @turn.color_kept = (params[:color] == 'white' ?
                                Turn::WHITE :
                                Turn::BLACK)
            @turn.save
        end

        redirect_to game_turn_path(@game, @turn, :p => @password)
    end

    def finish
        @turn = Turn.find(params[:turn_id])
        @game = @turn.game

        @turn.state = Turn::FINISHED

        @turn.handle_rescue_trouble params[:pilgrim_rescued]

        goal_words = 0
        if params[:pilgrim_used_goal_word] then goal_words += 1 end
        if params[:troublemakers_used_goal_word] then goal_words += 1 end
        @turn.goal_words_used = goal_words

        @turn.save

        redirect_to game_path(@game, :p => @password)
    end
end
