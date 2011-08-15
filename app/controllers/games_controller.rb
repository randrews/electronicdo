class GamesController < ApplicationController
    before_filter :check_password, :on => [:take_turn, :show]

    def check_password
        @game = Game.find(params[:id])

        # Private game, ask them for a password
        if !@game.password.blank? && params[:p] != @game.password
            @wrong_password = !params[:p].blank?
            render 'enter_password'
        end

        # They put in the right password (or there is none),
        # so store it in a var so we can use it in hidden fields
        @password = params[:p]
    end

    # POST /games/:id/take_turn
    def take_turn
        @game = Game.find(params[:id])
        @turn = Turn.new :game => @game
    end

    # GET /games
    def index
        @games = Game.all
    end

    # GET /games/1
    def show
        @game = Game.find(params[:id])
    end

    # GET /games/new
    def new
        @game = Game.new
    end

    # GET /games/1/edit
    def edit
        @game = Game.find(params[:id])
    end

    # POST /games
    def create
        @game = Game.new(params[:game])

        if @game.save
            redirect_to(@game, :notice => 'Game was successfully created.')
        else
            render :action => "new"
        end
    end

    # PUT /games/1
    def update
        @game = Game.find(params[:id])

        if @game.update_attributes(params[:game])
            redirect_to(@game, :notice => 'Game was successfully updated.')
        else
            render :action => "edit"
        end
    end

    # # DELETE /games/1
    # def destroy
    #     @game = Game.find(params[:id])
    #     @game.destroy
    #     redirect_to(games_url)
    # end
end
