export function displayFlashAlert (message) {
  const flashAlert = document.getElementById('flash-alert');

  hideFlashes();
  flashAlert.innerHTML = message;
  flashAlert.classList.remove('d-none');
}

export function displayFlashNotice(message) {
  const flashNotice = document.getElementById('flash-notice');

  hideFlashes();
  flashNotice.innerHTML = message;
  flashNotice.classList.remove('d-none');
}

function hideFlashes() {
  const flashMessages = document.querySelectorAll('.flash-message');

  flashMessages.forEach((flashMessage) => {
    flashMessage.classList.add('d-none');
  });
}
