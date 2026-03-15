# Nix Darwin Full System Configuration — Design Spec

**Date:** 2026-03-15
**Status:** Approved

---

## Context

The user has Nix Package Manager installed on an Apple Silicon MacBook (aarch64-darwin) and wants to manage their entire system configuration declaratively using Nix. They have a working but minimal nix-darwin flake in `/etc/nix-darwin` and a heavy Homebrew setup (50+ packages and casks). They recently started using GNU Stow for dotfiles, with the dotfiles living at `~/dotfiles_mac/` (backed by GitHub). The goal is to consolidate everything into a single, version-controlled, reproducible system config — with Nix as the one tool to rule them all.

**Known system state:**
- Username: `tb`, Apple Silicon (aarch64-darwin), Nix 2.31.3
- `~/.zshrc` is a **plain file** (not Stow-managed) — must be backed up with `mv`, not `stow -D`
- `~/.gitconfig` is a **plain file** (not Stow-managed) — same; git was never put under Stow
- `~/.gitconfig` references `~/.gitignore_global` which only contains `.DS_Store` — this will be inlined into `programs.git.ignores`, eliminating the external file
- `~/.zshrc` uses oh-my-zsh, zsh-autosuggestions, zsh-syntax-highlighting, starship, zoxide, fzf, Ghostty integration, and vivid for LS_COLORS
- Current `trusted-users = root` only — `tb` must be added before `darwin-rebuild switch` will work correctly

---

## Goals

- Single source of truth for the entire Mac setup, stored in `~/dotfiles_mac/`
- nix-darwin + Home Manager manage system and user config declaratively
- Homebrew stays operational but is controlled through Nix (gradual migration path)
- Stow is superseded by Home Manager over time (gradual migration path)
- Applying changes is a single no-sudo command from anywhere

---

## Non-Goals

- Big-bang migration of all Homebrew packages to nixpkgs on day one
- Migrating all dotfiles from Stow to Home Manager immediately
- Managing iOS/other devices

---

## Preconditions

- Homebrew is already installed at `/opt/homebrew/bin/brew` ✓
- Nix experimental features `nix-command` and `flakes` are enabled ✓
- `nix.settings.trusted-users` must include `tb` — currently only `root` is trusted; this is added in the nix-darwin config as the first change and applied before HM activation

---

## Architecture

### Repository Layout

```
~/dotfiles_mac/
├── flake.nix              # Root flake — nixpkgs, nix-darwin, home-manager inputs
├── flake.lock             # Pinned dependency versions
├── hosts/
│   └── mbp/
│       ├── default.nix    # nix-darwin system config: packages, macOS defaults, trusted-users
│       └── homebrew.nix   # Declarative Homebrew: taps, formulae, casks
└── home/
    ├── default.nix        # Home Manager root — imports all home modules
    ├── zsh.nix            # zsh via programs.zsh + oh-my-zsh module + plugins
    └── git.nix            # git via programs.git
```

### Component Responsibilities

| Component | Manages |
|-----------|---------|
| **nix-darwin** (`hosts/mbp/default.nix`) | System packages, macOS defaults, Nix daemon settings, trusted-users |
| **Home Manager** (`home/`) | User dotfiles, shell config, user-level packages |
| **nix-darwin homebrew module** (`hosts/mbp/homebrew.nix`) | Declarative Homebrew taps, formulae, and casks |

### Key Design Decisions

- **Home Manager as nix-darwin module** — not standalone. One command (`darwin-rebuild switch`) applies everything. The flake input must follow nixpkgs: `home-manager.inputs.nixpkgs.follows = "nixpkgs"` — without this a second nixpkgs copy is evaluated, causing slow builds.
- **`nix.settings.trusted-users = ["root" "tb"]`** — added to `hosts/mbp/default.nix`; must be the first thing applied.
- **`homebrew.enable = true` + `homebrew.onActivation.cleanup = "none"`** — `"none"` is critical during migration; it prevents the module from uninstalling packages not yet declared in `homebrew.nix`.
- **Shell ownership — Home Manager only**: zsh is managed via `programs.zsh` in `home/zsh.nix`. nix-darwin's `programs.zsh.enable` is NOT set, to avoid conflicting writes to `/etc/zshrc`.
- **zsh plugin strategy**: oh-my-zsh is managed by `programs.zsh.oh-my-zsh` (installs to Nix store). zsh-autosuggestions and zsh-syntax-highlighting are declared via `programs.zsh.plugins` using their nixpkgs packages — Homebrew-installed versions become redundant. Custom init (vivid, Ghostty integration, completions, PATH, aliases) goes in `programs.zsh.initExtra`.
- **git**: managed via `programs.git`. `excludesfile` is eliminated — global ignores declared inline as `programs.git.ignores = [".DS_Store"]`.
- **Required state versions**: `system.stateVersion = 6` (nix-darwin, already set) and `home.stateVersion = "24.11"` (Home Manager, set once at first activation, never changed).
- **`nixpkgs.hostPlatform = "aarch64-darwin"`** — preserved from existing flake.

---

## Migration Path

### Phase 1 — Foundation (implemented in this session)

1. Create new flake structure in `~/dotfiles_mac/`
2. Wire Home Manager as nix-darwin module
3. Set `nix.settings.trusted-users = ["root" "tb"]` in `hosts/mbp/default.nix`
4. **Back up plain dotfiles before first HM activation** (these are NOT Stow symlinks):
   ```bash
   mv ~/.zshrc ~/.zshrc.bak
   mv ~/.gitconfig ~/.gitconfig.bak
   ```
5. Migrate zsh config to `home/zsh.nix` using `programs.zsh` + `programs.zsh.oh-my-zsh`
6. Migrate git config to `home/git.nix` using `programs.git`; inline `.DS_Store` into `programs.git.ignores`
7. Add nix-darwin homebrew module; populate from:
   - `brew tap` → `homebrew.taps`
   - `brew list --formula` → `homebrew.brews`
   - `brew list --cask` → `homebrew.casks`
8. Run first `darwin-rebuild switch --flake ~/dotfiles_mac#mbp`
9. Archive old `/etc/nix-darwin/` directory

### Phase 2 — Dotfiles (user-paced)

- For each Stow-managed dotfile: `stow -D <package>` removes symlinks; add config to a new `home/*.nix` file, rebuild

### Phase 3 — Packages (user-paced)

- Move formulae from `homebrew.brews` to `environment.systemPackages` in nixpkgs one at a time
- GUI apps without nixpkgs equivalents stay in `homebrew.casks` indefinitely

---

## Cutover from `/etc/nix-darwin/`

1. Command changes to `darwin-rebuild switch --flake ~/dotfiles_mac#mbp`
2. Update any shell aliases pointing to the old path
3. Rename `/etc/nix-darwin/` to `/etc/nix-darwin.bak/` — do not delete until new setup is stable

---

## Day-to-Day Workflow

```bash
# Edit ~/dotfiles_mac/ then apply:
darwin-rebuild switch --flake ~/dotfiles_mac#mbp

# Update all inputs to latest:
nix flake update ~/dotfiles_mac && darwin-rebuild switch --flake ~/dotfiles_mac#mbp

# Roll back (system + Home Manager together, since HM is a nix-darwin module):
darwin-rebuild --rollback
```

> When Home Manager is integrated as a nix-darwin module, `darwin-rebuild --rollback` rolls back both the system generation and the Home Manager activation together. There is no separate `home-manager` CLI rollback needed.

---

## Verification

- `darwin-rebuild switch --flake ~/dotfiles_mac#mbp` completes without errors
- New terminal opens, zsh works, prompt renders correctly
- `ls -la ~/.zshrc` shows a `/nix/store/...` symlink
- `ls -la ~/.gitconfig` shows a `/nix/store/...` symlink
- `git config --global --list` returns correct name/email and no stale entries
- `brew list --formula` and `brew list --cask` match `homebrew.nix` declarations
- `nix show-config | grep trusted-users` shows `tb` is listed
- `/etc/nix-darwin/` is archived as `/etc/nix-darwin.bak/`

---

## Files Created/Modified

| File | Action |
|------|--------|
| `/private/etc/nix-darwin/` | Archived → `/private/etc/nix-darwin.bak/` |
| `~/dotfiles_mac/flake.nix` | Created |
| `~/dotfiles_mac/hosts/mbp/default.nix` | Created |
| `~/dotfiles_mac/hosts/mbp/homebrew.nix` | Created |
| `~/dotfiles_mac/home/default.nix` | Created |
| `~/dotfiles_mac/home/zsh.nix` | Created |
| `~/dotfiles_mac/home/git.nix` | Created |
| `~/.zshrc` | Backed up → `~/.zshrc.bak` |
| `~/.gitconfig` | Backed up → `~/.gitconfig.bak` |
| `~/.gitignore_global` | Content inlined into `programs.git.ignores`; file can be removed |
