{ pkgs, ... }:
{
  xdg.configFile."borders/bordersrc" = {
    executable = true;
    text = builtins.replaceStrings
      [ "borders \"\${options[@]}\"" ]
      [ "${pkgs.jankyborders}/bin/borders \"\${options[@]}\"" ]
      (builtins.readFile ../borders/bordersrc);
  };
}
