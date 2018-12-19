import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['image', 'photoURLInput']

  connect() {
    this.updateImagePreview();
  }

  preview(event) {
    if (this.photoURL == '') { return; }
    this.updateImagePreview();
  }

  get photoURL() {
    return this.photoURLInputTarget.value;
  }

  updateImagePreview() {
    if (this.photoURL == '') { return; }
    this.imageTarget.style = `background-image: url('${this.photoURL}')`;
  }
}
