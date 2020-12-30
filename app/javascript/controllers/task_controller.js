import { Controller } from "stimulus";
import StimulusReflex from "stimulus_reflex";

export default class extends Controller {
  static targets = ["checkbox", "collapse"];

  connect() {
    StimulusReflex.register(this);

    $(this.collapseTarget).on("show.bs.collapse", () => {
      this.checkboxTarget.classList.add("d-none");
    });

    $(this.collapseTarget).on("hide.bs.collapse", () => {
      this.checkboxTarget.classList.remove("d-none");
    });
  }

  destroy(event) {
    const confirmation = confirm("Are you sure?");

    if (confirmation) {
      this.stimulate("TaskReflex#destroy", event.currentTarget);
    }
  }
}
