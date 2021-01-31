class ListChannel < ApplicationCable::Channel
  def subscribed
    stream_for List.find(params[:list_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
