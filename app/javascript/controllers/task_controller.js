import { Controller } from "stimulus";
import StimulusReflex from "stimulus_reflex";

export default class extends Controller {
  static classes = ["complete"];
  static targets = ["checkbox", "label"];
  static values = { complete: Boolean };

  connect() {
    StimulusReflex.register(this);

    if (this.completeValue) {
      this.checkboxTarget.checked = true;
      this.labelTarget.classList.add(this.completeClass);
    }
  }
}
