# /Users/tb/dotfiles_mac/home/git.nix
{ ... }:
{
  programs.git = {
    enable = true;
    userName = "tb";
    userEmail = "tb@cirqle.no";

    # Replaces ~/.gitignore_global (which only contained .DS_Store)
    ignores = [ ".DS_Store" ];

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
