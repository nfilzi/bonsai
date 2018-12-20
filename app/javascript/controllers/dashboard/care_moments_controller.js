import { Controller } from 'stimulus'
import * as Flashes from '../../helpers/flashes'

export default class extends Controller {
  refresh(event) {
    const [data, ...detail] = event.detail;

    this.element.outerHTML = data.content.buttons;
    Flashes.displayFlashNotice(data.notice);

    this.dispatchRefresh(data);
  }

  dispatchRefresh(data) {
    const event = new CustomEvent('care-moments-updated', { detail: { user_stats: data.content.user_stats }});
    this.element.dispatchEvent(event);
  }

  handleError(event) {
    const [data, ...detail] = event.detail;
    Flashes.displayFlashAlert(data.alert)
  }
}
