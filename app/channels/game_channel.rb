class GameChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info("hello games channel")
    Rails.logger.info("params: #{params}")

    game = Game.find(params[:game_id])
    stream_for game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
