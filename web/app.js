const app = document.getElementById('app');
const hudStylesEl = document.getElementById('hudStyles');
const speedometerStylesEl = document.getElementById('speedometerStyles');
const closeBtn = document.getElementById('closeBtn');

const post = (event, body = {}) =>
  fetch(`https://${GetParentResourceName()}/${event}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify(body),
  });

function createCard(style, selectedId, onClick) {
  const card = document.createElement('button');
  card.className = `card ${style.id === selectedId ? 'active' : ''}`;
  card.type = 'button';
  card.innerHTML = `
    <strong>#${style.id} ${style.label}</strong>
    <div class="badge" style="background:${style.color};"></div>
  `;
  card.addEventListener('click', () => onClick(style.id));
  return card;
}

function render(payload) {
  hudStylesEl.innerHTML = '';
  speedometerStylesEl.innerHTML = '';

  payload.hudStyles.forEach((style) => {
    hudStylesEl.appendChild(
      createCard(style, payload.hudStyle, (styleId) => post('selectHudStyle', { styleId }))
    );
  });

  payload.speedometerStyles.forEach((style) => {
    speedometerStylesEl.appendChild(
      createCard(style, payload.speedometerStyle, (styleId) => post('selectSpeedometerStyle', { styleId }))
    );
  });
}

window.addEventListener('message', (event) => {
  const { action, data } = event.data;

  if (action === 'open') {
    app.classList.remove('hidden');
    render(data);
  }

  if (action === 'close') {
    app.classList.add('hidden');
  }
});

closeBtn.addEventListener('click', () => post('close'));
document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') post('close');
});
