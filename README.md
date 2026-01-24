# Godot Visual Script Starter

**CLI tools for Godot + Orchestrator project automation**

Start a new Godot project with `gd-init` from anywhere.

[한국어 문서 (Korean)](README_KO.md)

---

## Features

- **Global CLI commands**: Use `gd-init` anywhere, like `npm` or `git`
- **Merge into existing folders**: Add Godot to folders with existing docs
- **Auto addon installation**: Orchestrator setup included
- **Version management**: Install and switch between Godot versions

---

## Installation

```batch
:: 1. Clone this repository
git clone https://github.com/your-username/godot-visual-script-starter.git

:: 2. Run install script (adds to PATH)
cd godot-visual-script-starter
install.bat

:: 3. Open a NEW terminal (required for PATH)

:: 4. Install GodotEnv + Godot
gd-setup
```

**Requirements:** .NET SDK 6.0+ ([Download](https://dotnet.microsoft.com/download))

---

## CLI Commands

| Command | Description |
|---------|-------------|
| `gd-setup` | Install GodotEnv and Godot 4.5 |
| `gd-init` | Create new project / initialize existing folder |
| `gd-edit` | Open Godot editor |
| `gd-update` | Manage Godot versions |
| `gd-addon` | Manage addons |

---

## Quick Start

### Create a new project

```batch
gd-init my-game
cd my-game
gd-edit
```

### Initialize in existing folder (Key Feature!)

```batch
:: Navigate to existing folder with docs
cd my-existing-project

:: Initialize Godot (keeps existing files)
gd-init --here
```

Your existing `docs/`, `README.md`, etc. will be preserved!

---

## gd-init Options

| Option | Short | Description |
|--------|-------|-------------|
| `--here` | `-h` | Initialize in current folder |
| `--force` | `-f` | Overwrite existing files |
| `--no-addon` | | Skip Orchestrator installation |
| `--help` | | Show help |

### Generated Structure

```
my-game/
├── project.godot       # Godot project file
├── addons.json         # GodotEnv addon config
├── .gitignore
├── scenes/
│   └── main.tscn
├── scripts/
├── assets/
│   ├── sprites/
│   ├── audio/
│   ├── fonts/
│   └── models/
└── addons/
    └── orchestrator/   # Auto-installed
```

---

## Version Management

```batch
:: List installed versions
gd-update list

:: Install specific version
gd-update install 4.4

:: Switch version
gd-update use 4.4

:: Install latest
gd-update latest
```

---

## Addon Management

```batch
:: Install all addons from addons.json
gd-addon install

:: Update addons
gd-addon update

:: Add addon presets
gd-addon add orchestrator
gd-addon add dialogue
gd-addon add phantom-camera
gd-addon add terrain3d
```

---

## Troubleshooting

### "gd-init is not recognized"

Open a new terminal window. PATH changes require a new session.

### "plugin.cfg parsing failed" error

Orchestrator is a **GDExtension**, not a Plugin!

**Fix:**
1. Open `project.godot` in text editor
2. Remove orchestrator from `[editor_plugins]` section
3. Restart Godot

```ini
# Wrong (remove this)
[editor_plugins]
enabled=PackedStringArray("res://addons/orchestrator/plugin.cfg")

# Correct (leave empty)
[editor_plugins]
enabled=PackedStringArray()
```

### Orchestrator tab not visible

GDExtension loads automatically. Check the **bottom panel** of Godot editor for "Orchestrator" tab.

---

## Version Compatibility

| Godot | Orchestrator | addons.json checkout |
|-------|--------------|---------------------|
| 4.2.x | v2.0.x | `"checkout": "2.0"` |
| 4.3.x | v2.1.x | `"checkout": "2.1"` |
| 4.4.x | v2.2.x | `"checkout": "2.2"` |
| **4.5.x** | **v2.3.x** | `"checkout": "2.3"` |

---

## Documentation

| Document | Description |
|----------|-------------|
| [CLI Guide](docs/CLI_GUIDE.md) | Detailed CLI usage (Korean) |
| [Orchestrator Guide](docs/ORCHESTRATOR_GUIDE.md) | Orchestrator setup guide (Korean) |

---

## Related Links

- [GodotEnv GitHub](https://github.com/chickensoft-games/GodotEnv)
- [Orchestrator Docs](https://docs.cratercrash.space/orchestrator/)
- [Godot Engine](https://godotengine.org/)

---

## Uninstall

```batch
uninstall.bat
```

---

## License

MIT License

---

## Contributing

Issues and pull requests are welcome!
