import { Controller } from "stimulus";
import StimulusReflex from "stimulus_reflex";

export default class extends Controller {
  static classes = ["incomplete"];
  static targets = ["checkbox", "collapse"];

  connect() {
    StimulusReflex.register(this);

    $(this.collapseTarget).on("show.bs.collapse", () => {
      this.checkboxTarget.classList.add("d-none");
      this.element.classList.remove(this.incompleteClass);
    });

    $(this.collapseTarget).on("hide.bs.collapse", () => {
      this.checkboxTarget.classList.remove("d-none");
      this.element.classList.add(this.incompleteClass);
    });
  }

  destroy(event) {
    event.preventDefault();
    const confirmation = confirm("Are you sure?");

    if (confirmation) {
      this.stimulate("TaskReflex#destroy", event.currentTarget);
    }
  }
}
