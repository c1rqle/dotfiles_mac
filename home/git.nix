# /Users/tb/dotfiles_mac/home/git.nix
{ ... }:
{
  programs.git = {
    enable = true;

    # Replaces ~/.gitignore_global (which only contained .DS_Store)
    ignores = [ ".DS_Store" ];

    settings = {
      user.name = "cirqle";
      user.email = "dev@cirqle.no";
      init.defaultBranch = "main";
    };
  };
}
