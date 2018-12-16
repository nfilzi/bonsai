const setupSmoothScroll = () => {
  document.addEventListener("DOMContentLoaded", (event) => {
    const links = document.querySelectorAll('a[data-scroll="true"]');

    links.forEach((link) => {
      link.addEventListener('click', (e) => {
        e.preventDefault();
        const targetHash = e.currentTarget.hash;

        document.querySelector(targetHash).scrollIntoView(
          {
            block: 'start',
            behavior: 'smooth'
          }
        );
      });
    });
  });
};

export { setupSmoothScroll };
