# /Users/tb/dotfiles_mac/home/hammerspoon.nix
{ pkgs, ... }:
let
  yabaiBin = "${pkgs.yabai}/bin/yabai";
in
{
  home.file = {
    ".hammerspoon/init.lua".source = ../hammerspoon/init.lua;
    ".hammerspoon/modules/system.lua".source = ../hammerspoon/modules/system.lua;

    ".hammerspoon/Spoons".source = ../hammerspoon/Spoons;
    ".hammerspoon/Spoons".recursive = true;

    ".hammerspoon/modules/yabai.lua".text = builtins.replaceStrings
      [ "/Users/tb/.local/bin/yabai" ]
      [ yabaiBin ]
      (builtins.readFile ../hammerspoon/modules/yabai.lua);

    ".hammerspoon/modules/apps.lua".text = builtins.replaceStrings
      [ "/Users/tb/.local/bin/yabai" ]
      [ yabaiBin ]
      (builtins.readFile ../hammerspoon/modules/apps.lua);
  };
}
