class GamesController < ApplicationController
    before_filter :check_password, :only => [:take_turn, :show]

    def check_password
        @password = password_valid_for?(params[:id])
    end

    # POST /games/:id/take_turn
    def start_turn
        @game = Game.find(params[:id])
        @turn = @game.create_turn
        redirect_to game_turn_path(@game,@turn)
    end

    # GET /games
    def index
        @games = Game.all
    end

    # GET /games/1
    def show
        @game = Game.find(params[:id])
        @turn = @game.latest_turn
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
            redirect_to(game_path(@game, :p => @game.password), :notice => 'Game was successfully created.')
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
