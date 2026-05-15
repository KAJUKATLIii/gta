# qbox-hud-selector

A simple FiveM/Qbox resource that adds a selector menu with:

- **20 HUD style options**
- **20 speedometer style options**

## Install

1. Copy this folder into your server `resources` directory.
2. Add to `server.cfg`:

```cfg
ensure qbox-hud-selector
```

## Usage

- Type `/hudmenu` or press **F10**.
- Choose the HUD and speedometer styles from the menu.
- Use the placement editor to drag HUD/SPEED widgets and save their screen positions.

## Notes

This resource demonstrates selection/storage logic and a customizable UI list. Hook the selected style IDs into your existing HUD/speedometer rendering code where needed.


## Placement data

Saved positions are stored using FiveM resource KVP keys:
- `qbox_hud_placement`
- `qbox_speedometer_placement`

Both use normalized coordinates (`x` and `y`, from `0.0` to `1.0`).
