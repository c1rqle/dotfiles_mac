# /Users/tb/dotfiles_mac/home/nvim.nix
#
# Neovim installed via programs.neovim (home-manager).
# LazyVim config files are symlinked from this repo into ~/.config/nvim/.
# lazy.nvim and all plugins are downloaded at runtime (not via Nix) —
# this avoids fighting Nix's read-only store for plugin state.
#
# NOTE: lazyvim.json and lazy-lock.json are NOT symlinked here.
#       LazyVim writes them at runtime; leave them as regular files.

{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = false; # zsh.nix handles EDITOR with SSH fallback
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = false;

    # Tools that must be on PATH for Neovim / LazyVim to work correctly.
    # Mason can install LSPs; these are the non-LSP essentials.
    extraPackages = with pkgs; [
      ripgrep      # telescope live_grep
      fd           # telescope file_files
      stylua       # Lua formatter (used by LazyVim)
      lua-language-server
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source                    = ../nvim/init.lua;
    "nvim/stylua.toml".source                 = ../nvim/stylua.toml;
    "nvim/lua/config/lazy.lua".source         = ../nvim/lua/config/lazy.lua;
    "nvim/lua/config/options.lua".source      = ../nvim/lua/config/options.lua;
    "nvim/lua/config/keymaps.lua".source      = ../nvim/lua/config/keymaps.lua;
    "nvim/lua/config/autocmds.lua".source     = ../nvim/lua/config/autocmds.lua;
  };
}
