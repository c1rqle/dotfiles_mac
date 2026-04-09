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
# Neovim
    "nvim/init.lua".source = ../nvim/init.lua;
    "nvim/lazyvim.json".source = ../nvim/lazyvim.json;
    "nvim/stylua.toml".source = ../nvim/lazyvim.json;
    "nvim/lua/plugins/disabled.lua".source = ../nvim/lua/plugins/disabled.lua;
    "nvim/lua/plugins/lsp.lua".source = ../nvim/lua/plugins/lsp.lua;
    "nvim/lua/config/autocmds.lua".source = ../nvim/lua/config/autocmds.lua;
    "nvim/lua/config/options.lua".source = ../nvim/lua/config/options.lua;
    "nvim/lua/config/keymaps.lua".source = ../nvim/lua/config/keymaps.lua;
    "nvim/lua/config/lazy.lua".source = ../nvim/lua/config/lazy.lua;
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
