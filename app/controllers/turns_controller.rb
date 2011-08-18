class TurnsController < ApplicationController
    before_filter :check_game_password

    def check_game_password
        @password = password_valid_for? params[:game_id]
    end

    # GET /games/:game_id/turns/:id
    def show
        @turn = Turn.find(params[:id])
    end
end
