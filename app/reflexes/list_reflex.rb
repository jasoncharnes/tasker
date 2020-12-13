class ListReflex < StimulusReflex::Reflex
  def create_task
    sleep 2
    list = List.find(element.dataset.list_id)
    list.tasks.create(task_params)
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end
end
