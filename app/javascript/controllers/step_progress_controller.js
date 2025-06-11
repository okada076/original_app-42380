import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  connect() {
    this.checkboxTargets.forEach(checkbox => {
      checkbox.addEventListener("change", this.toggleCheck.bind(this))
    })
  }

  toggleCheck(event) {
    const checkbox = event.target
    const stepId = checkbox.dataset.stepId
    const checked = checkbox.checked

    const stepCard = checkbox.closest(".step-label").querySelector(".step-card")
  if (checked) {
    stepCard.classList.add("checked-card")
  } else {
    stepCard.classList.remove("checked-card")
  }

    fetch("/step_progresses", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        growing_step_id: stepId,
        checked: checked
      })
    })
      .then(response => {
        if (response.ok) {
          console.log("保存成功")
        } else {
          console.error("保存失敗", response.status)
          alert("保存に失敗しました")
        }
      })
      .catch(error => {
        console.error("通信エラー", error)
        alert("通信エラーが発生しました")
      })
  }
}
