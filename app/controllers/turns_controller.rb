class TurnsController < ApplicationController
    before_filter :check_game_password

    def check_game_password
        @password = password_valid_for? params[:game_id]
    end

    # GET /games/:game_id/turns/:id
    def show
        @turn = Turn.find(params[:id])
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
end
