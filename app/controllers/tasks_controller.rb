class TasksController < ApplicationController
  def show
    @list = List.find(params[:list_id])
    @task = @list.tasks.includes(:comments).find(params[:id])
    @new_comment = Comment.new
  end
end
