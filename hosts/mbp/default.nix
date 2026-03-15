{ pkgs, self, ... }:
{
  imports = [ ./homebrew.nix ];

  environment.systemPackages = [
    pkgs.vim
  ];

  # Allow flakes and the new nix CLI
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # tb must be in trusted-users for Home Manager binary cache substitution
  nix.settings.trusted-users = [ "root" "tb" ];

  # Required for user-facing options (homebrew, etc.) since nix-darwin
  # now runs all system activation as root
  system.primaryUser = "tb";

  # Declare the user so Home Manager can find the home directory
  users.users.tb = {
    name = "tb";
    home = "/Users/tb";
  };

  # Track which git commit this config was built from
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Never change this after initial setup
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
