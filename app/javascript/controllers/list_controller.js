import { Controller } from "stimulus";
import consumer from "../channels/consumer";
import CableReady from "cable_ready";
import StimulusReflex from "stimulus_reflex";
import Sortable from "sortablejs";

export default class extends Controller {
  static targets = ["form", "tasks"];

  connect() {
    StimulusReflex.register(this);

    consumer.subscriptions.create(
      { channel: "ListChannel", list_id: this.data.get("id") },
      {
        received: (data) => {
          if (data.cableReady) CableReady.perform(data.operations);
        },
      }
    );

    Sortable.create(this.tasksTarget, {
      handle: ".incomplete",
      onEnd: (event) => this.reorder(event),
    });
  }

  reorder(event) {
    this.stimulate("TaskReflex#reorder", event.item, event.newIndex);
  }

  beforeCreateTask(element) {
    element.querySelectorAll("input").forEach((input) => input.blur());
    element.classList.add("form-disabled");
  }

  createTaskSuccess() {
    this.formTarget.reset();
  }

  createTaskError(element, name, error) {
    alert(error);
  }
}
