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

## Notes

This resource demonstrates selection/storage logic and a customizable UI list. Hook the selected style IDs into your existing HUD/speedometer rendering code where needed.
