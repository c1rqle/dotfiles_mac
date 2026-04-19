{ ... }:
{
  imports = [
    ./packages.nix
    ./borders.nix
    ./tmux.nix
    ./git.nix
    ./zsh.nix
    ./files.nix
    ./nushell.nix
    ./hammerspoon.nix
    ./nvim.nix
  ];

  home.username = "tb";
  home.homeDirectory = "/Users/tb";

  # Never change this after first activation
  home.stateVersion = "24.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
