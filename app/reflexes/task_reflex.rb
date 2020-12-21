class TaskReflex < StimulusReflex::Reflex
  before_reflex :find_task

  def toggle
    if element.checked
      @task.update(completed_at: Time.current, completer: connection.current_user)
    else
      @task.update(completed_at: nil, completer: nil)
    end
  end

  def destroy
    @task.destroy
  end

  def reorder(position)
    @task.insert_at(position)
  end

  def assign
    @task.update(assignee_id: element.value)
    morph "#task-#{@task.id}-assignee", @task.assignee_name
  end

  private

  def find_task
    @task = Task.find(element.dataset.id)
  end
end
