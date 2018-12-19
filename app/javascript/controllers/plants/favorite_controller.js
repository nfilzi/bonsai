import { Controller } from 'stimulus'

export default class extends Controller {
  refresh(event) {
    const [data, ...detail] = event.detail;
    this.element.outerHTML = data.content;
  }
}
