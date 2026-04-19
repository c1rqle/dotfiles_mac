{ pkgs, self, user, ... }:
{
  imports = [
    ./homebrew.nix
    ./yabai.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Auto-start Hammerspoon
  launchd.user.agents.hammerspoon = {
    command = "/Applications/Hammerspoon.app/Contents/MacOS/Hammerspoon";
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
    };
  };
  # Auto-start borders
  launchd.user.agents.borders = {
    command = "/bin/bash -lc /Users/${user}/.config/borders/bordersrc";
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
    };
  };

  environment.systemPackages = [
    pkgs.vim
  ];

  # Allow flakes and the new nix CLI
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # tb must be in trusted-users for Home Manager binary cache substitution
  nix.settings.trusted-users = [ "root" "tb" ];

  # Required for user-facing options (homebrew, etc.) since nix-darwin
  # now runs all system activation as root
  system.primaryUser = user;

  # Declare the user so Home Manager can find the home directory
  users.users.${user} = {
    home = "/Users/${user}";
  };

  # Track which git commit this config was built from
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Never change this after initial setup
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
