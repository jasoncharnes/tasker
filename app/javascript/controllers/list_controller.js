import { Controller } from "stimulus";
import StimulusReflex from "stimulus_reflex";

export default class extends Controller {
  static targets = ["form"];

  connect() {
    StimulusReflex.register(this);
  }

  createTaskSuccess() {
    this.formTarget.reset();
  }
}
