class ListsController < ApplicationController
  include CableReady::Broadcaster

  def index
    @lists = current_team.lists
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
    @list = current_user.team.lists.new(list_params)

    if @list.save
      cable_ready[ListsChannel].remove(
        selector: "#list-#{params.dig(:list, :client_id)}"
      ).broadcast_to(current_user)
      cable_ready[TeamChannel].insert_adjacent_html(
        selector: "#lists",
        position: "beforeend",
        html: render_to_string(@list, assigns: { new_task: Task.new })
      ).broadcast_to(current_user.team)
    else
      cable_ready[ListsChannel].morph(
        selector: "#list-#{params.dig(:list, :client_id)}",
        html: render_to_string(partial: "lists/form", locals: { list: @list })
      )
      cable_ready.broadcast_to(current_user)
    end
  end

  def destroy
    @list = current_team.lists.find(params[:id])
    @list.destroy!
    cable_ready[ListChannel].remove(selector: dom_id(@list))
    cable_ready.broadcast_to(@list)
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
