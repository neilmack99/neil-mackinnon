document.addEventListener('DOMContentLoaded', function () {
  const btn = document.getElementById('updateBtn');
  const dyn = document.getElementById('dynamic');
  let clicks = 0;
  function update() {
    clicks += 1;
    const now = new Date();
    dyn.innerHTML = `<strong>Updated:</strong> ${now.toLocaleString()}<br>Clicks: ${clicks}`;
  }
  if (btn) btn.addEventListener('click', update);
  // initial message
  if (dyn) dyn.textContent = 'Click the button to update this area.';

  // Menu toggle for small screens
  const menuToggle = document.getElementById('menuToggle');
  if (menuToggle) {
    menuToggle.addEventListener('click', function () {
      document.body.classList.toggle('show-menu');
    });
    // close menu when a link is clicked (mobile)
    const links = document.querySelectorAll('.menu a');
    links.forEach(function (link) {
      link.addEventListener('click', function () {
        document.body.classList.remove('show-menu');
      });
    });
  }
});
