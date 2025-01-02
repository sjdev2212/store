import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "names"]

  greet() {
    const element = this.namesTarget
    const names= element.value
    alert(`Hello, ${names}!`)
  }
}