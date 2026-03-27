{ ... }:
{
  xdg.enable = true;

  xdg.configFile = {
    "espanso/match/packages/spelling/package.yml".source = ../espanso/match/packages/spelling/package.yml;
    "espanso/match/packages/terminal/package.yml".source = ../espanso/match/packages/terminal/package.yml;
    "espanso/match/packages/symbols/package.yml".source = ../espanso/match/packages/symbols/package.yml;
    "espanso/match/packages/emojis/package.yml".source = ../espanso/match/packages/emojis/package.yml;
    "espanso/match/packages/git/package.yml".source = ../espanso/match/packages/git/package.yml;
    "espanso/config/default.yml".source = ../espanso/config/default.yml;
    "espanso/match/base.yml".source = ../espanso/match/base.yml;
    "ghostty/appearance".source = ../ghostty/appearance;
    "ghostty/keybinds".source = ../ghostty/keybinds;
    "ghostty/config".source = ../ghostty/config;
    "ghostty/fonts".source = ../ghostty/fonts;
    "lsd/config.yaml".source = ../lsd/config.yaml;
    "yabai/yabairc".source = ../yabai/yabairc;
    "yabai/yabairc".executable = true;
    "zsh_custom/aliases".source = ../zsh/aliases.zsh;
    "starship/starship.toml".source = ../starship/starship.toml;
    "alacritty/alacritty.toml".source = ../alacritty/alacritty.toml;
  };
}
