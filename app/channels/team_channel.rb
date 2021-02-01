class TeamChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user.team
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
