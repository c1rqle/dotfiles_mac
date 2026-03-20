{ ... }:
{
  xdg.enable = true;

  xdg.configFile = {
    "espanso/config/default.yml".source = ../espanso/config/default.yml;
    "espanso/match/base.yml".source = ../espanso/match/base.yml;
    "ghostty/appearance".source = ../ghostty/appearance;
    "ghostty/config".source = ../ghostty/config;
    "ghostty/fonts".source = ../ghostty/fonts;
    "ghostty/keybinds".source = ../ghostty/keybinds;
    "lsd/config.yaml".source = ../lsd/config.yaml;
    "starship/starship.toml".source = ../starship/starship.toml;
    "yabai/yabairc".source = ../yabai/yabairc;
    "yabai/yabairc".executable = true;
    "zsh_custom/aliases".source = ../zsh/aliases.zsh;
  };
}
