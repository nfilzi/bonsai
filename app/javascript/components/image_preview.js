const setupImagePreview = () => {
  // WITH TURBOLINKS
  document.addEventListener("turbolinks:load", () => {
  // WITHOUT TURBOLINKS
  // document.addEventListener("DOMContentLoaded", (event) => {
    const imageInputs = document.querySelectorAll('input[data-image-preview="true"]');

    imageInputs.forEach((input) => {
      updateImagePreview(input);

      input.addEventListener('change', (e) => {
        updateImagePreview(e.currentTarget);
      });
    });
  });
};

const updateImagePreview = (imageInput) => {
  const imageURL      = imageInput.value;
  const previewTarget = imageInput.dataset.target;

  if (imageURL == '') { return; }
  document.querySelector(previewTarget).style = `background-image: url('${imageURL}')`;
};

export { setupImagePreview };
