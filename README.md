# ADM (Automated Data-Goy Machine)

**Automated Data-Goy Machine**; the physical arm of the "Dataist" ecosystem for decentralized and offline content distribution.

ADM eliminates the need for high-speed internet, providing a secure and intelligent platform for transferring data packages (movies, software, documentation) in public environments. Like an "ATM for content," this device delivers knowledge directly to the user.

## Project Structure

```text
adm/
├── assets/              # Global project assets (Logo, project-wide branding)
├── config/              # System and network configuration
├── docs/                # Technical documentation (Sphinx)
│   ├── assets/          # Documentation-specific assets (Diagrams, charts)
│   ├── build/           # Generated documentation output
│   ├── Makefile         # Documentation build commands
│   ├── make.bat         # Windows build script
│   └── source/          # Documentation sources
│       ├── conf.py      # Sphinx configuration
│       ├── index.rst    # Main documentation file
│       ├── _static/     # Static assets (images, CSS)
│       ├── _templates/  # Custom templates
│       └── topics/      # Technical topics
│           ├── architecture/
│           ├── contributing/
│           ├── deployment/
│           ├── hardware/
│           ├── software/
│           └── troubleshooting/
├── hardware/            # Hardware design and manufacturing
│   ├── assembly/        # Assembly blueprints
│   └── fabrication/     # Fabrication files (CNC/Laser)
├── LICENSE              # Project license
├── logs/                # Operational and debug logs
├── README.md            # Project introduction
├── scripts/             # Automation scripts
├── sim/                 # Digital Twin (3D Simulator)
│   ├── assets/          # Simulation assets (3D models, textures, environment)
│   ├── logic/           # Godot scripts for content movement
│   └── bridge.py        # Python-to-Godot bridge
├── src/                 # Source code modules
│   ├── adm_backend/     # Content management and logic
│   ├── adm_firmware/    # Embedded system code
│   ├── adm_frontend/    # UI kiosk application
│   └── adm_shared/      # Common libraries and protocol definitions
├── tests/               # Integration and unit tests
└── VERSION              # Current project version

