class TaskReflex < StimulusReflex::Reflex
  def toggle
    Task.find(element.dataset.id).update(completed_at: element.checked ? Time.current : nil)
  end
end
