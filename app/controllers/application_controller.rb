class ApplicationController < ActionController::Base
    protect_from_forgery

    # Meant to be called from before_filters.
    # Pass in a game ID. If the game needs no password, or params[:p]
    # is the right password, then it returns the password (so you can
    # put it in a hidden field on your form).
    # Otherwise, it renders game/enter_password
    def password_valid_for? game_id, password=params[:p]
        @game = Game.find(game_id)

        # Private game, ask them for a password
        if !@game.password.blank? && password != @game.password
            @wrong_password = !password.blank?
            render 'games/enter_password'
        end

        password
    end
end
