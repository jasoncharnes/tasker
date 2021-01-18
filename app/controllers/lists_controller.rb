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
        selector: "#list-#{params.dig(:list, :client_id)}",
        html: render_to_string(@list, assigns: { new_task: Task.new })
      )
    else
      cable_ready[ListsChannel].morph(
        selector: "#list-#{params.dig(:list, :client_id)}",
        html: render_to_string(partial: "lists/form", locals: { list: @list })
      )
    end

    cable_ready.broadcast_to(current_user)
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy!
    cable_ready[ListsChannel].remove(selector: dom_id(@list))
    cable_ready.broadcast_to(current_user)
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
