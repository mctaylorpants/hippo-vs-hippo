class GamesController < ApplicationController
  before_action :find_game, only: [:show, :join, :choose]

  def new
    @game = Game.new
  end

  def create
    @game = Game.create!(host: current_user)

    redirect_to @game
  end

  def show
    Rails.logger.info("current user: #{current_user}")
  end

  def join
    if @game.join(as: current_user)
      refresh_state
    else
      raise @game.errors.full_messages
    end
  end

  def choose
    if @game.host == current_user
      @game.update!(host_choice: params[:choice])
    else
      @game.update!(opponent_choice: params[:choice])
    end

    refresh_state
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  helper_method :current_user
  def current_user
    session[:user_name] ||= Player.new.name
  end

  def refresh_state
    @game.broadcast_replace_to(@game, :host, target: "game_state", partial: "games/game_state", locals: { game: @game, player: @game.host })
    @game.broadcast_replace_to(@game, :opponent, target: "game_state", partial: "games/game_state", locals: { game: @game, player: @game.opponent })
  end
end
