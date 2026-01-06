document.addEventListener('DOMContentLoaded', function () {
  const btn = document.getElementById('updateBtn');
  const dyn = document.getElementById('dynamic');
  let clicks = 0;
  function update() {
    clicks += 1;
    const now = new Date();
    dyn.innerHTML = `<strong>Updated:</strong> ${now.toLocaleString()}<br>Clicks: ${clicks}`;
  }
  btn.addEventListener('click', update);
  // initial message
  dyn.textContent = 'Click the button to update this area.';
});
