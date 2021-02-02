require "rails_helper"

RSpec.describe TaskReflex, type: :reflex do
  let(:reflex) { build_reflex(connection: { current_user: user }) }
  let(:user) { FactoryBot.create(:user) }

  describe "#toggle" do
    subject { reflex.run(:toggle) }

    context "element is checked" do
      let(:task) { FactoryBot.create(:task) }

      before do
        reflex.element.dataset.id = task.id
        reflex.element.checked = true
      end

      it "completes the task" do
        expect { subject }.to change { task.reload.complete? }.from(false).to(true)
      end

      it "broadcasts CableReady operations" do
        expect { subject }.to broadcast(
          remove: { selector: "#task_#{task.id}" },
          insert_adjacent_html: {
            selector: "#list_#{task.list_id} #complete-tasks",
            position: "beforeend",
            html: kind_of(String)
          },
          broadcast_to: task.list
        )
      end
    end

    context "element is unchecked" do
      let(:task) { FactoryBot.create(:task, :complete) }

      before do
        reflex.element.dataset.id = task.id
        reflex.element.checked = false
      end

      it "incompletes the task" do
        expect { subject }.to change { task.reload.complete? }.from(true).to(false)
      end

      it "broadcasts CableReady operations" do
        expect { subject }.to broadcast(
          remove: { selector: "#task_#{task.id}" },
          insert_adjacent_html: {
            selector: "#list_#{task.list_id} #incomplete-tasks",
            position: "beforeend",
            html: kind_of(String)
          },
          broadcast_to: task.list
        )
      end
    end
  end
end
