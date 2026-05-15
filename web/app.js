const app = document.getElementById('app');
const hudStylesEl = document.getElementById('hudStyles');
const speedometerStylesEl = document.getElementById('speedometerStyles');
const closeBtn = document.getElementById('closeBtn');
const stage = document.getElementById('placementStage');
const hudWidget = document.getElementById('hudWidget');
const speedometerWidget = document.getElementById('speedometerWidget');
const saveHudPlacement = document.getElementById('saveHudPlacement');
const saveSpeedometerPlacement = document.getElementById('saveSpeedometerPlacement');
const resetPlacements = document.getElementById('resetPlacements');
const liveHud = document.getElementById('liveHud');
const liveSpeedometer = document.getElementById('liveSpeedometer');
const liveHudStyle = document.getElementById('liveHudStyle');
const liveSpeedStyle = document.getElementById('liveSpeedStyle');
const liveSpeedValue = document.getElementById('liveSpeedValue');

let speedTick = 0;

const post = (event, body = {}) =>
  fetch(`https://${GetParentResourceName()}/${event}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify(body),
  }).then((res) => res.json().catch(() => ({})));

function createCard(style, selectedId, onClick) {
  const card = document.createElement('button');
  card.className = `card ${style.id === selectedId ? 'active' : ''}`;
  card.type = 'button';
  card.innerHTML = `<strong>#${style.id} ${style.label}</strong><div class="badge" style="background:${style.color};"></div>`;
  card.addEventListener('click', () => onClick(style.id));
  return card;
}

function setWidgetPosition(widget, placement) {
  widget.style.left = `${placement.x * 100}%`;
  widget.style.top = `${placement.y * 100}%`;
}

function setLivePosition(widget, placement) {
  widget.style.left = `${placement.x * 100}vw`;
  widget.style.top = `${placement.y * 100}vh`;
}

function getWidgetPosition(widget) {
  return {
    x: Math.min(Math.max(widget.offsetLeft / stage.clientWidth, 0), 1),
    y: Math.min(Math.max(widget.offsetTop / stage.clientHeight, 0), 1),
  };
}

function makeDraggable(widget) {
  let dragging = false;
  let offsetX = 0;
  let offsetY = 0;

  const move = (clientX, clientY) => {
    const rect = stage.getBoundingClientRect();
    const x = Math.min(Math.max(clientX - rect.left - offsetX, 0), rect.width - widget.offsetWidth);
    const y = Math.min(Math.max(clientY - rect.top - offsetY, 0), rect.height - widget.offsetHeight);
    widget.style.left = `${x}px`;
    widget.style.top = `${y}px`;
  };

  widget.addEventListener('mousedown', (e) => {
    dragging = true;
    offsetX = e.offsetX;
    offsetY = e.offsetY;
  });

  document.addEventListener('mousemove', (e) => {
    if (!dragging) return;
    move(e.clientX, e.clientY);
  });

  document.addEventListener('mouseup', () => {
    dragging = false;
  });
}

function updateLiveDisplays(payload) {
  const hud = payload.hudStyles.find((item) => item.id === payload.hudStyle);
  const speedo = payload.speedometerStyles.find((item) => item.id === payload.speedometerStyle);

  if (payload.placements) {
    setLivePosition(liveHud, payload.placements.hud);
    setLivePosition(liveSpeedometer, payload.placements.speedometer);
  }

  if (hud) {
    liveHud.style.borderColor = hud.color;
    liveHudStyle.textContent = `Style #${hud.id} ${hud.label}`;
  }

  if (speedo) {
    liveSpeedometer.style.borderColor = speedo.color;
    liveSpeedStyle.textContent = `Style #${speedo.id} ${speedo.label}`;
  }
}

function render(payload) {
  hudStylesEl.innerHTML = '';
  speedometerStylesEl.innerHTML = '';

  payload.hudStyles.forEach((style) => {
    hudStylesEl.appendChild(createCard(style, payload.hudStyle, (styleId) => post('selectHudStyle', { styleId })));
  });

  payload.speedometerStyles.forEach((style) => {
    speedometerStylesEl.appendChild(createCard(style, payload.speedometerStyle, (styleId) => post('selectSpeedometerStyle', { styleId })));
  });

  if (payload.placements) {
    setWidgetPosition(hudWidget, payload.placements.hud);
    setWidgetPosition(speedometerWidget, payload.placements.speedometer);
  }

  updateLiveDisplays(payload);
}

window.addEventListener('message', (event) => {
  const { action, data } = event.data;
  if (!data) return;

  render(data);

  if (action === 'open') {
    app.classList.remove('hidden');
  }

  if (action === 'close') {
    app.classList.add('hidden');
  }
});

makeDraggable(hudWidget);
makeDraggable(speedometerWidget);

saveHudPlacement.addEventListener('click', async () => {
  const pos = getWidgetPosition(hudWidget);
  const result = await post('savePlacement', { element: 'hud', x: pos.x, y: pos.y });
  if (result.placements) {
    setLivePosition(liveHud, result.placements.hud);
  }
});

saveSpeedometerPlacement.addEventListener('click', async () => {
  const pos = getWidgetPosition(speedometerWidget);
  const result = await post('savePlacement', { element: 'speedometer', x: pos.x, y: pos.y });
  if (result.placements) {
    setLivePosition(liveSpeedometer, result.placements.speedometer);
  }
});

resetPlacements.addEventListener('click', async () => {
  const result = await post('resetPlacements');
  if (result.placements) {
    setWidgetPosition(hudWidget, result.placements.hud);
    setWidgetPosition(speedometerWidget, result.placements.speedometer);
    setLivePosition(liveHud, result.placements.hud);
    setLivePosition(liveSpeedometer, result.placements.speedometer);
  }
});

setInterval(() => {
  speedTick = (speedTick + 7) % 220;
  liveSpeedValue.textContent = `${speedTick}`.padStart(3, '0');
}, 300);

closeBtn.addEventListener('click', () => post('close'));
document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') post('close');
});
