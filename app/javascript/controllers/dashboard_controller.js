import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['userStats'];

  updateUserStats(event) {
    const { user_stats, ...detail } = event.detail
    this.userStatsTarget.outerHTML = user_stats

    $(this.userStatsTarget).find('[data-toggle="popover"]').popover()
  }
}
