{ ... }:
{
  xdg.enable = true;
  xdg.configFile = {
    "lsd/config.yaml".source = ../lsd/config.yaml;
    "zsh_custom/aliases".source = ../zsh/aliases.zsh;
    "starship/starship.toml".source = ../starship/starship.toml;
    "alacritty/alacritty.toml".source = ../alacritty/alacritty.toml;
# Yabai
    "yabai/yabairc".source = ../yabai/yabairc;
    "yabai/yabairc".executable = true;
# Ghostty
    "ghostty/appearance".source = ../ghostty/appearance;
    "ghostty/keybinds".source = ../ghostty/keybinds;
    "ghostty/config".source = ../ghostty/config;
    "ghostty/fonts".source = ../ghostty/fonts;
# Espanso
    "espanso/match/base.yml".source = ../espanso/match/base.yml;
    "espanso/match/packages/spelling/package.yml".source = ../espanso/match/packages/spelling/package.yml;
    "espanso/match/packages/terminal/package.yml".source = ../espanso/match/packages/terminal/package.yml;
    "espanso/match/packages/symbols/package.yml".source = ../espanso/match/packages/symbols/package.yml;
    "espanso/match/packages/personal/package.yml".source = ../espanso/match/packages/personal/package.yml;
    "espanso/match/packages/emojis/package.yml".source = ../espanso/match/packages/emojis/package.yml;
    "espanso/match/packages/git/package.yml".source = ../espanso/match/packages/git/package.yml;
    "espanso/match/packages/ssh/package.yml".source = ../espanso/match/packages/ssh/package.yml;
    "espanso/config/default.yml".source = ../espanso/config/default.yml;
  };
}
