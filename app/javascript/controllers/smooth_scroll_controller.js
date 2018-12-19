import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['link'];

  scroll(event) {
    if (this.enabled == false) { return; }
    event.preventDefault();

    this.targetedElement.scrollIntoView(
      {
        block:    'start',
        behavior: 'smooth'
      }
    );
  }

  get enabled() {
    return this.data.get('enabled') == 'true'
  }

  get targetedElement() {
    const targetHash = this.linkTarget.hash;

    return document.querySelector(targetHash);
  }
}
