{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.username = "tb";
  home.homeDirectory = "/Users/tb";

  # Never change this after first activation
  home.stateVersion = "24.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  home.packages = [
  pkgs.qbittorrent
];
}
