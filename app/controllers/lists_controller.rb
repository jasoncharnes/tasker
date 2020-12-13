class ListsController < ApplicationController
  def index
    @lists = List.all
    @new_task ||= Task.new
  end
end
