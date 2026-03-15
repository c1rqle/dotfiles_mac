# Nix Darwin Full Config Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Move the nix-darwin flake from `/etc/nix-darwin/` to `~/dotfiles_mac/`, wire in Home Manager (as a nix-darwin module), migrate zsh and git dotfiles, and declare the full Homebrew setup declaratively — giving a single-command, no-sudo system config.

**Architecture:** nix-darwin owns system-level config (packages, macOS defaults, trusted-users, Homebrew); Home Manager (as nix-darwin module) owns user-level config (shell, git, dotfiles); the Homebrew module keeps all current packages under declarative control with `cleanup = "none"` so nothing gets removed during the migration.

**Tech Stack:** Nix flakes, nix-darwin, Home Manager, nixpkgs-unstable, GNU Stow (temporary), Homebrew (controlled via nix-darwin homebrew module)

---

## Chunk 1: Flake + System Config

### Task 1: Create directory structure

**Files:**
- Create: `~/dotfiles_mac/hosts/mbp/` (directory)
- Create: `~/dotfiles_mac/home/` (directory)

- [ ] **Step 1: Create directories**

```bash
mkdir -p ~/dotfiles_mac/hosts/mbp
mkdir -p ~/dotfiles_mac/home
```

- [ ] **Step 2: Verify**

```bash
ls ~/dotfiles_mac/hosts/mbp ~/dotfiles_mac/home
```
Expected: both exist (empty)

---

### Task 2: Create `flake.nix`

**Files:**
- Create: `~/dotfiles_mac/flake.nix`

> The new flake adds `home-manager` as an input alongside nix-darwin. Both must follow the same nixpkgs to avoid a second nixpkgs evaluation. `self` is passed to modules via `specialArgs` so `system.configurationRevision` can track the git commit.

- [ ] **Step 1: Write `flake.nix`**

```nix
# ~/dotfiles_mac/flake.nix
{
  description = "tb's macOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
  {
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        ./hosts/mbp/default.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tb = import ./home/default.nix;
        }
      ];
    };
  };
}
```

---

### Task 3: Create `hosts/mbp/default.nix`

**Files:**
- Create: `~/dotfiles_mac/hosts/mbp/default.nix`

> `trusted-users` MUST include `tb` — currently only `root` is trusted, which causes Home Manager binary cache substitution to fail silently. The homebrew import is included here but `hosts/mbp/homebrew.nix` is created in Chunk 4.

- [ ] **Step 1: Write `hosts/mbp/default.nix`**

```nix
# ~/dotfiles_mac/hosts/mbp/default.nix
{ pkgs, self, ... }:
{
  # Homebrew module (populated in Chunk 4)
  # imports = [ ./homebrew.nix ];

  environment.systemPackages = [
    pkgs.vim
  ];

  # Allow flakes and the new nix CLI
  nix.settings.experimental-features = "nix-command flakes";

  # tb must be in trusted-users for Home Manager binary cache substitution
  nix.settings.trusted-users = [ "root" "tb" ];

  # Track which git commit this config was built from
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Never change this after initial setup
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
```

---

### Task 4: Create minimal `home/default.nix` and do the first build

**Files:**
- Create: `~/dotfiles_mac/home/default.nix`

> This is the bare-minimum Home Manager config. No dotfiles yet — we just want to confirm the wiring works before touching anything on the system.

- [ ] **Step 1: Write `home/default.nix`**

```nix
# ~/dotfiles_mac/home/default.nix
{ pkgs, ... }:
{
  home.username = "tb";
  home.homeDirectory = "/Users/tb";

  # Never change this after first activation
  home.stateVersion = "24.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
```

- [ ] **Step 2: Update the flake lock to fetch home-manager**

```bash
cd ~/dotfiles_mac
nix flake update
```
Expected: downloads home-manager and updates `flake.lock`

- [ ] **Step 3: First build — no dotfile changes yet**

```bash
darwin-rebuild switch --flake ~/dotfiles_mac#mbp
```
Expected: builds successfully, prints activation messages

- [ ] **Step 4: Archive the old flake (do this NOW, before any further builds)**

The old config at `/etc/nix-darwin/` still exists. Archive it immediately after the first successful build so there is no ambiguity about which flake is active going forward.

```bash
sudo mv /private/etc/nix-darwin /private/etc/nix-darwin.bak
```

- [ ] **Step 5: Verify trusted-users is applied**

> Note: `trusted-users` is a Nix daemon setting. `darwin-rebuild switch` triggers a daemon restart via launchd, so the new setting is active after the build completes. Verify now to confirm:

```bash
nix show-config | grep trusted-users
```
Expected: output includes `tb`

- [ ] **Step 6: Commit**

```bash
cd ~/dotfiles_mac
git add flake.nix flake.lock hosts/ home/
git commit -m "feat(nix): move flake to dotfiles_mac, wire Home Manager"
```

---

## Chunk 2: Git Dotfiles

### Task 5: Migrate git config to Home Manager

**Files:**
- Create: `~/dotfiles_mac/home/git.nix`
- Modify: `~/dotfiles_mac/home/default.nix` (add import)
- Backup: `~/.gitconfig` → `~/.gitconfig.bak`

> `~/.gitconfig` is a plain file (not Stow-managed). It must be removed before Home Manager activates, or HM will refuse to write its own version and exit with a "collision" error.
>
> The `excludesfile` that pointed to `~/.gitignore_global` (which only contained `.DS_Store`) is replaced by `programs.git.ignores` — no external file needed.

- [ ] **Step 1: Write `home/git.nix`**

```nix
# ~/dotfiles_mac/home/git.nix
{ ... }:
{
  programs.git = {
    enable = true;
    userName = "tb";
    userEmail = "tb@cirqle.no";

    # Replaces ~/.gitignore_global (which only contained .DS_Store)
    ignores = [ ".DS_Store" ];

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
```

- [ ] **Step 2: Add git.nix to home/default.nix imports**

```nix
# ~/dotfiles_mac/home/default.nix
{ pkgs, ... }:
{
  imports = [
    ./git.nix
  ];

  home.username = "tb";
  home.homeDirectory = "/Users/tb";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
```

- [ ] **Step 3: Back up the current gitconfig**

```bash
mv ~/.gitconfig ~/.gitconfig.bak
```

> Source files in `~/dotfiles_mac/` are untouched — only `~/.gitconfig` (the plain file) is moved.

- [ ] **Step 4: Build**

```bash
darwin-rebuild switch --flake ~/dotfiles_mac#mbp
```
Expected: succeeds, Home Manager writes a new `~/.gitconfig` symlink

- [ ] **Step 5: Verify git config**

```bash
ls -la ~/.gitconfig
```
Expected: symlink pointing to `/nix/store/...`

```bash
git config --global --list
```
Expected: shows `user.name=tb`, `user.email=tb@cirqle.no`, `init.defaultbranch=main`, no stale entries

- [ ] **Step 6: Commit**

```bash
cd ~/dotfiles_mac
git add home/git.nix home/default.nix
git commit -m "feat(home): manage git config via Home Manager"
```

---

## Chunk 3: Zsh Dotfiles

### Task 6: Migrate zsh config to Home Manager

**Files:**
- Create: `~/dotfiles_mac/home/zsh.nix`
- Modify: `~/dotfiles_mac/home/default.nix` (add import)
- Backup: `~/.zshrc` → `~/.zshrc.bak`

> `~/.zshrc` is a plain file (not Stow-managed). Same situation as gitconfig.
>
> oh-my-zsh is managed by `programs.zsh.oh-my-zsh` (installed to Nix store — the existing `~/.oh-my-zsh` dir becomes unused but is not deleted). `zsh-autosuggestions` and `zsh-syntax-highlighting` move from Homebrew to nixpkgs. `fzf`, `starship`, and `zoxide` each get their own HM `programs.*` block which handles their zsh integration automatically — they are removed from the oh-my-zsh plugins list to avoid double-init.
>
> **Bug fixed from original:** `export PATH="/opt/homebrew/bin:$PATH >> ~/.zprofile && source ~/.zprofile"` — the redirect was inside the string. Fixed to `export PATH="/opt/homebrew/bin:$PATH"`.
>
> **zoxide:** initialized with `--cmd c` so the jump command remains `c` (not the default `z`).

- [ ] **Step 1: Write `home/zsh.nix`**

```nix
# ~/dotfiles_mac/home/zsh.nix
{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;

      # fzf, starship, zoxide removed — each has its own HM programs.* block below
      plugins = [ "git" "colored-man-pages" "tmux" ];

      # Points to user-managed custom plugins/aliases dir
      custom = "$HOME/.config/zsh_custom";

      # Set before oh-my-zsh is sourced
      extraConfig = ''
        DISABLE_UNTRACKED_FILES_DIRTY="true"
        zstyle ':omz:update' mode auto
        zstyle ':omz:update' frequency 4
      '';
    };

    # External plugins sourced from nixpkgs (replaces Homebrew-installed versions)
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        # Verified path: /nix/store/...-zsh-autosuggestions-0.7.1/share/zsh/plugins/zsh-autosuggestions/
        file = "share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];

    # Runs at the very top of .zshrc — before oh-my-zsh and compinit
    initExtraFirst = ''
      # PATH
      export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
      export PATH="/opt/homebrew/bin:$PATH"
      export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
      # Ruby gems — path is version-dependent; only add if dir exists
      for _ruby_gems_dir in /opt/homebrew/lib/ruby/gems/*/bin; do
        [[ -d "$_ruby_gems_dir" ]] && export PATH="$_ruby_gems_dir:$PATH"
      done
      unset _ruby_gems_dir

      # Homebrew
      export HOMEBREW_NO_AUTO_UPDATE=1

      # LS_COLORS (requires vivid in PATH, installed via Homebrew)
      export LS_COLORS="$(vivid generate tokyonight-night)"

      # Ghostty terminal integration
      if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
      fi
    '';

    # Runs after oh-my-zsh and plugin sourcing
    initExtra = ''
      # Shell options
      setopt autocd extendedglob nomatch notify
      unsetopt beep
      bindkey -v

      # Completion tuning (oh-my-zsh handles compinit itself — do NOT call it again here)
      zstyle ':completion:*' completer _oldlist _expand _complete _match _correct _approximate _prefix
      zstyle ':completion:*' max-errors 99 not-numeric
      zstyle ':completion:*' match-original both
      zstyle ':completion:*' old-menu false
      zstyle ':completion:*' completions 1
      zstyle ':completion:*' substitute 1
      zstyle ':completion:*' word true
      zstyle ':completion:*' glob 1

      # Editor
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='vim'
      else
        export EDITOR='nvim'
      fi

      # Compilation flags (for Ruby and other native extensions)
      export ARCHFLAGS="-arch $(uname -m)"
      export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
      export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"

      # Starship config location
      export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

      # Perl local::lib
      eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

      # Aliases (user-managed, not migrated to Nix yet)
      [[ -f "$HOME/.config/zsh_custom/aliases.zsh" ]] && source "$HOME/.config/zsh_custom/aliases.zsh"
    '';
  };

  # fzf — handles its own zsh integration (replaces manual source lines in old .zshrc)
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # starship — handles its own zsh integration (replaces eval "$(starship init zsh)")
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # zoxide — --cmd c preserves the 'c' jump command from the original setup
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "c" ];
  };
}
```

- [ ] **Step 2: Add zsh.nix to home/default.nix imports**

```nix
# ~/dotfiles_mac/home/default.nix
{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.username = "tb";
  home.homeDirectory = "/Users/tb";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
```

- [ ] **Step 3: Back up the current zshrc**

```bash
mv ~/.zshrc ~/.zshrc.bak
```

- [ ] **Step 4: Build**

```bash
darwin-rebuild switch --flake ~/dotfiles_mac#mbp
```
Expected: builds successfully. Home Manager writes a Nix store symlink at `~/.zshrc`.

- [ ] **Step 5: Verify zsh**

```bash
ls -la ~/.zshrc
```
Expected: symlink pointing into `/nix/store/...`

Open a **new terminal window** (not just a new tab in the same session) and verify:

```bash
echo $SHELL           # /bin/zsh or /run/current-system/sw/bin/zsh
zsh --version         # any recent version
starship --version    # confirms starship is available
c --help 2>/dev/null || echo "zoxide: c cmd available"
fzf --version
```

- [ ] **Step 6: Commit**

```bash
cd ~/dotfiles_mac
git add home/zsh.nix home/default.nix
git commit -m "feat(home): manage zsh config via Home Manager"
```

---

## Chunk 4: Homebrew Module + Cleanup

### Task 7: Create `hosts/mbp/homebrew.nix`

**Files:**
- Create: `~/dotfiles_mac/hosts/mbp/homebrew.nix`
- Modify: `~/dotfiles_mac/hosts/mbp/default.nix` (uncomment import)

> `cleanup = "none"` is critical here. If set to `"uninstall"` or `"zap"`, any package NOT in these lists would be removed on the next `darwin-rebuild switch`. Keep it at `"none"` until you're confident the lists are complete.
>
> Only `brew leaves` output is declared (top-level packages, not their transitive deps). Homebrew manages deps automatically.
>
> `docker` appears as both a formula (CLI) and a cask — this reflects the current installed state. If it causes a conflict, remove the cask `"docker"` entry (keeping `"docker-desktop"`).

- [ ] **Step 1: Write `hosts/mbp/homebrew.nix`**

```nix
# ~/dotfiles_mac/hosts/mbp/homebrew.nix
{ ... }:
{
  homebrew = {
    enable = true;

    # IMPORTANT: Keep at "none" during migration.
    # Only change to "uninstall" when you're sure all packages are declared.
    onActivation.cleanup = "none";

    taps = [
      "felixkratz/formulae"
    ];

    brews = [
      "borders"             # from felixkratz/formulae tap
      "clang-format"
      "claude-code-templates"
      "claudekit"
      "click"
      "cloudflared"
      "cmake"
      "docker"
      "docker-compose"
      "fastfetch"
      "fd"
      "findutils"
      # "fzf"             # managed by programs.fzf in home/zsh.nix
      "gcc"
      "gh"
      "git"
      "git-filter-repo"
      "imagemagick"
      "lsd"
      "luarocks"
      "macmon"
      "make"
      "man-db"
      "mas"
      "mpv"
      "neovim"
      "ninja"
      "nnn"
      "ollama"
      "openjdk"
      "openssh"
      "perl"
      "pillow"
      "pnpm"
      "powerline-go"
      "ripgrep"
      "ruby"
      # "starship"        # managed by programs.starship in home/zsh.nix
      "stow"
      "syncthing"
      "tmux"
      "translate-shell"
      "vivid"
      "wasm-component-ld"
      "wasm-micro-runtime"
      "wasm-pack"
      "wasm-tools"
      "wireshark"
      "xdg-ninja"
      "yarn"
      # "zoxide"          # managed by programs.zoxide in home/zsh.nix
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];

    casks = [
      "aldente"
      "android-platform-tools"
      "auto-claude"
      "bettertouchtool"
      "biglybt"
      "chatgpt"
      "claude"
      "claude-code"
      "discord"
      # "docker"          # removed: "docker" cask = Docker Desktop alias; keep docker-desktop below
      "docker-desktop"
      "espanso"
      "font-awesome-terminal-fonts"
      "font-hack-nerd-font"
      "font-ligature-symbols"
      "font-powerline-symbols"
      "font-sf-pro"
      "font-sketchybar-app-font"
      "font-symbols-only-nerd-font"
      "ghostty"
      "github"
      "hammerspoon"
      "karabiner-elements"
      "linearmouse"
      "logi-options+"
      "logitech-g-hub"
      "notion"
      "pearcleaner"
      "qbittorrent"
      "raycast"
      "sf-symbols"
      "spaceid"
      "spotify"
      "surfshark"
      "syncthing-app"
      "termius"
      "tuta-mail"
      "ubersicht"
      "ungoogled-chromium"
      "vscodium"
    ];
  };
}
```

- [ ] **Step 2: Uncomment the import in `hosts/mbp/default.nix`**

Update `hosts/mbp/default.nix` — remove the comment from the imports block:

```nix
{ pkgs, self, ... }:
{
  imports = [ ./homebrew.nix ];

  environment.systemPackages = [
    pkgs.vim
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.trusted-users = [ "root" "tb" ];
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
```

- [ ] **Step 3: Build**

```bash
darwin-rebuild switch --flake ~/dotfiles_mac#mbp
```
Expected: succeeds; Homebrew module activates, verifying declared packages are present

- [ ] **Step 4: Verify Homebrew is under declarative control**

```bash
brew list --formula | wc -l   # should match approximate count
brew list --cask | wc -l
```
Expected: existing counts unchanged (nothing was removed with `cleanup = "none"`)

- [ ] **Step 5: Commit**

```bash
cd ~/dotfiles_mac
git add hosts/mbp/homebrew.nix hosts/mbp/default.nix
git commit -m "feat(homebrew): declare all packages in nix-darwin homebrew module"
```

---

### Task 8: Final verification

> `/etc/nix-darwin/` was already archived in Task 4, Step 4.

- [ ] **Step 1: Full verification checklist**

```bash
# System rebuild works
darwin-rebuild switch --flake ~/dotfiles_mac#mbp

# trusted-users
nix show-config | grep trusted-users
# Expected: includes "tb"

# zsh dotfiles managed by Nix
ls -la ~/.zshrc
# Expected: /nix/store/... symlink

# git dotfiles managed by Nix
ls -la ~/.gitconfig
# Expected: /nix/store/... symlink

# git config correct
git config --global --list
# Expected: user.name=tb, user.email=tb@cirqle.no, no stale entries

# No stale Stow symlinks for migrated configs
ls -la ~ | grep dotfiles_mac
# Expected: nothing pointing to dotfiles_mac for zsh or git paths

# Homebrew still intact
brew list --formula | grep git
brew list --cask | grep ghostty
```

- [ ] **Step 2: Open a fresh terminal and test the full shell experience**

- Prompt renders (starship)
- `c <dir>` works (zoxide with --cmd c)
- `fzf` launches (Ctrl-T or however bound)
- Aliases work
- Git completions work
- Colors render (vivid LS_COLORS)

- [ ] **Step 3: Final commit**

```bash
cd ~/dotfiles_mac
git add -A
git commit -m "chore: archive old /etc/nix-darwin flake, full setup verified"
```

---

## How to apply changes going forward

```bash
# Edit any file in ~/dotfiles_mac/
# Apply:
darwin-rebuild switch --flake ~/dotfiles_mac#mbp

# Update all inputs (nixpkgs, nix-darwin, home-manager) to latest:
cd ~/dotfiles_mac && nix flake update
darwin-rebuild switch --flake ~/dotfiles_mac#mbp

# Roll back (covers both system and Home Manager together):
darwin-rebuild --rollback
```

## Next steps (future, user-paced)

**Phase 2 — Remaining dotfiles** (each is a separate, safe step):
```bash
# For each Stow-managed config (ghostty, nvim, tmux, starship, etc.):
stow -D <package>          # removes symlinks, source files stay
# Add config content to a new home/<name>.nix
darwin-rebuild switch --flake ~/dotfiles_mac#mbp
```

**Phase 3 — Package migration** (optional, whenever you feel like it):
- Pick a formula from `homebrew.brews`, check `nix search nixpkgs <name>`
- If found: add to `environment.systemPackages` in `hosts/mbp/default.nix`, remove from `homebrew.brews`
- Rebuild — Homebrew will eventually stop managing it
