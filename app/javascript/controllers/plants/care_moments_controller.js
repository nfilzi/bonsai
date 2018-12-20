import { Controller } from 'stimulus';
import * as Flashes from '../../helpers/flashes';

export default class extends Controller {
  static targets = ['buttons', 'moments', 'overview']

  refresh(event) {
    const [data, ...detail] = event.detail;

    this.overviewTarget.outerHTML = data.content.overview;
    this.buttonsTarget.outerHTML  = data.content.buttons;
    this.momentsTarget.outerHTML  = data.content.moments;

    Flashes.displayFlashNotice(data.notice);
  }

  handleError(event) {
    const [data, ...detail] = event.detail;
    Flashes.displayFlashAlert(data.alert);
  }
}
