class ListsController < ApplicationController
  include CableReady::Broadcaster

  def index
    @lists = List.all
    @new_task ||= Task.new
  end

  def new
    cable_ready[ListsChannel].insert_adjacent_html(
      selector: "#lists",
      html: render_to_string(partial: "lists/form", locals: { list: List.new })
    )
    cable_ready.broadcast_to(current_user)
  end

  def create
    @list = List.new(list_params)

    if @list.save
      cable_ready[ListsChannel].outer_html(
        selector: "#new-list",
        html: render_to_string(@list)
      )
      cable_ready.broadcast_to(current_user)
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
