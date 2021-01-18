class ListsController < ApplicationController
  include CableReady::Broadcaster

  def index
    @lists = List.all
    @new_task ||= Task.new
  end

  def new
    cable_ready[ListsChannel].console_log(
      message: "Hello from Rails!"
    )
    cable_ready.broadcast_to(current_user)
  end
end
