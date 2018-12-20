import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['careMomentNeeded'];

  refresh() {
    if (this.careMomentNeededTargets.length == 0) {
      this.element.classList.add('d-none');
    }
  }
}
