# Nix-Darwin Configuration

This repository contains my personal nix-darwin configuration for macOS, providing a declarative and reproducible system setup. It uses Nix flakes for dependency management and includes configurations for both system-level settings and user-specific configurations through home-manager.

## Features

- System configuration using nix-darwin
- User configuration using home-manager
- Catppuccin theme integration
- Modular configuration structure
- Siplifyed commands using Just


## Project Structure

```
.
├── flake.nix           # Main flake configuration
├── flake.lock         # Locked dependencies
├── home/              # Home-manager configurations
├── modules/           # System modules
│   ├── nix-core.nix   # Core Nix settings
│   ├── system.nix     # System configuration
│   ├── apps.nix       # Application configuration
│   └── host-users.nix # User management
└── Justfile          # Command shortcuts and workflows
```

## Usage

### Basic Commands

The project uses Just as a command runner to simplify common operations. Here are the main commands:

#### System Management
```bash
just darwin        # Build and switch to new system configuration
just darwin-debug  # Build and switch with debug output
```

#### Home Manager
```bash
just home          # Apply home-manager configuration
```

#### Nix Management
```bash
just up            # Update all flake inputs
just upp <input>   # Update specific flake input
just clean         # Remove old generations
just gc            # Garbage collect unused packages
just fmt           # Format Nix files
```

### Manual Usage

If you prefer not to use Just, you can run the commands directly:

```bash
# Build and switch system configuration
nix build .#darwinConfigurations.vm-mac.system
./result/sw/bin/darwin-rebuild switch --flake .#vm-mac

# Apply home-manager configuration
home-manager switch --flake .
```

### First Install

To set up this configuration on a new macOS machine, follow these steps:

1. Install Nix package manager by one of follosing methods (Determinate preferred):
 
    1. [Official Nix installer from `nixos.org`](https://nixos.org/download)
    2. [Determinate System’s Nix Installer for the shell](https://github.com/DeterminateSystems/nix-installer)
    3. [Determinate Systems’s graphical installer for macOS](https://determinate.systems/posts/graphical-nix-installer)

    check if it works: 

    ```sh
    $ nix run "nixpkgs#hello"
    Hello, world!
    ```

2. Install Homebrew: 
    [Homebrew — The Missing Package Manager for macOS (or Linux)](https://brew.sh/)

3. Install Rozetta (Optional):
```sh
softwareupdate --install-rosetta --agree-to-license
```
4. Clone this repository.

5. Adjust variables in `flake.nix` file

```nix
username = "neversad";
useremail = "neversad@null.computer";
system = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
hostname = "mbair";
```

6. Install `Just`: 
```sh
brew install just
```

7. Bootstrap nix using just: 
```sh
just darwin
```

8. Apply Home-manager configuration (Standalone): 
```sh
just home
```


## Configuration

The configuration is split into several modules:

- `nix-core.nix`: Core Nix settings and package management
- `system.nix`: System-wide configuration
- `apps.nix`: Application-specific settings
- `host-users.nix`: User management and permissions


## Maintenance

Regular maintenance tasks:

- Update dependencies: `just up`
- Clean old generations: `just clean`
- Garbage collect: `just gc`

## Contributing

Feel free to fork this repository and adapt it to your needs. If you find any issues or have suggestions, please open an issue or submit a pull request.

## License

This project is open source and available under the MIT License. 