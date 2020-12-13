class TaskReflex < StimulusReflex::Reflex
  def toggle
    Task.find(element.dataset.id).update(completed_at: element.checked ? Time.current : nil)
  end

  def destroy
    Task.find(element.dataset.id).destroy
  end

  def create
    list = List.find(element.dataset.list_id)
    list.tasks.create(task_params)
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end
end
