# /Users/tb/dotfiles_mac/home/git.nix
{ ... }:
{
  programs.git = {
    enable = true;

    # Replaces ~/.gitignore_global (which only contained .DS_Store)
    ignores = [ ".DS_Store" ];

    settings = {
      user.name = "tb";
      user.email = "tb@cirqle.no";
      init.defaultBranch = "main";
    };
  };
}
