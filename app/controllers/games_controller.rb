class GamesController < ApplicationController
  before_action :find_game, only: [:show, :join]

  def new
    @game = Game.new
  end

  def create
    @game = Game.create!(host_uuid: current_user_uuid)

    redirect_to @game
  end

  def show
    Rails.logger.info("current user: #{current_user_uuid}")
  end

  def join
    if @game.join(as: current_user_uuid)
      @game.broadcast_replace(target: "game_state", partial: "games/game_state", locals: { game: @game })
    else
      raise @game.errors.full_messages
    end
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  helper_method :current_user_uuid
  def current_user_uuid
    session[:anonymous_user_id] ||= "user-#{SecureRandom.uuid}"
  end
end
