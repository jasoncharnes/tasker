class CommentsController < ApplicationController
  include CableReady::Broadcaster

  def create
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:task_id])
    @comment = @task.comments.new(comment_params)

    if @comment.save
      cable_ready[TaskChannel].insert_adjacent_html(
        selector: "#comments",
        html: render_to_string(@comment)
      )
    end

    cable_ready.broadcast_to(@task)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
