class GamesController < ApplicationController
  before_action :find_game, only: [:show, :join, :choose, :rematch]

  def new
    @game = Game.new
  end

  def create
    @game = Game.create!(host: current_user_name)

    redirect_to @game
  end

  def show
    Rails.logger.info("current user: #{current_user_name}")
  end

  def join
    if @game.join(as: current_user_name)
      refresh_state
    else
      raise @game.errors.full_messages
    end
  end

  def choose
    if @game.host == current_user_name
      @game.update!(host_choice: params[:choice])
    else
      @game.update!(opponent_choice: params[:choice])
    end

    refresh_state
  end

  def rematch
    @game.rematch
    refresh_state
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  helper_method :current_user_name
  def current_user_name
    session[:user_name] ||= Player.new.name
  end

  def refresh_state
    @game.broadcast_replace_to(@game, :host, target: "game_state", partial: "games/game_state", locals: { game: @game, current_player: @game.host, challenger: @game.opponent })
    @game.broadcast_replace_to(@game, :opponent, target: "game_state", partial: "games/game_state", locals: { game: @game, current_player: @game.opponent, challenger: @game.host})
  end
end
