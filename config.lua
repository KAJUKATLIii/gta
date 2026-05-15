Config = {}

-- Command that opens the selector UI
Config.OpenCommand = 'hudmenu'

-- Default style indexes (1-20)
Config.DefaultHudStyle = 1
Config.DefaultSpeedometerStyle = 1

-- 20 HUD styles (name + base color)
Config.HudStyles = {
    { id = 1,  label = 'Classic Blue',      color = '#3b82f6' },
    { id = 2,  label = 'Emerald',           color = '#10b981' },
    { id = 3,  label = 'Crimson',           color = '#ef4444' },
    { id = 4,  label = 'Sunset',            color = '#f97316' },
    { id = 5,  label = 'Royal Purple',      color = '#8b5cf6' },
    { id = 6,  label = 'Gold',              color = '#eab308' },
    { id = 7,  label = 'Slate',             color = '#64748b' },
    { id = 8,  label = 'Aqua',              color = '#06b6d4' },
    { id = 9,  label = 'Rose',              color = '#f43f5e' },
    { id = 10, label = 'Lime',              color = '#84cc16' },
    { id = 11, label = 'Neon Pink',         color = '#ec4899' },
    { id = 12, label = 'Ocean Deep',        color = '#0ea5e9' },
    { id = 13, label = 'Forest',            color = '#16a34a' },
    { id = 14, label = 'Amber',             color = '#f59e0b' },
    { id = 15, label = 'Midnight',          color = '#1e293b' },
    { id = 16, label = 'Ice',               color = '#a5f3fc' },
    { id = 17, label = 'Coral',             color = '#fb7185' },
    { id = 18, label = 'Lavender',          color = '#c4b5fd' },
    { id = 19, label = 'Mint',              color = '#6ee7b7' },
    { id = 20, label = 'Obsidian',          color = '#111827' }
}

-- 20 speedometer styles
Config.SpeedometerStyles = {
    { id = 1,  label = 'Minimal Arc',         color = '#22d3ee' },
    { id = 2,  label = 'Needle Redline',      color = '#ef4444' },
    { id = 3,  label = 'Digital Green',       color = '#22c55e' },
    { id = 4,  label = 'Holo Violet',         color = '#8b5cf6' },
    { id = 5,  label = 'Retro Amber',         color = '#f59e0b' },
    { id = 6,  label = 'Carbon White',        color = '#f8fafc' },
    { id = 7,  label = 'Street Blue',         color = '#3b82f6' },
    { id = 8,  label = 'Track Orange',        color = '#fb923c' },
    { id = 9,  label = 'Pulse Pink',          color = '#ec4899' },
    { id = 10, label = 'Rally Lime',          color = '#a3e635' },
    { id = 11, label = 'Touring Cyan',        color = '#06b6d4' },
    { id = 12, label = 'Titan Gray',          color = '#94a3b8' },
    { id = 13, label = 'Inferno',             color = '#dc2626' },
    { id = 14, label = 'Stealth Black',       color = '#0f172a' },
    { id = 15, label = 'Pearl',               color = '#e2e8f0' },
    { id = 16, label = 'Velocity Purple',     color = '#7c3aed' },
    { id = 17, label = 'Turbo Teal',          color = '#14b8a6' },
    { id = 18, label = 'Sunburst',            color = '#f97316' },
    { id = 19, label = 'Nightwave',           color = '#0ea5e9' },
    { id = 20, label = 'Matrix',              color = '#16a34a' }
}


-- Default placement values in normalized screen coordinates (0.0-1.0)
Config.DefaultHudPlacement = { x = 0.03, y = 0.78 }
Config.DefaultSpeedometerPlacement = { x = 0.83, y = 0.78 }
