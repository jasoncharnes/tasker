class TaskChannel < ApplicationCable::Channel
  def subscribed
    stream_for Task.find(params[:task_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
