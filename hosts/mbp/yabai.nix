{ pkgs, ... }:
{
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    extraConfig = builtins.readFile ../../yabai/yabairc;
  };

  environment.etc."sudoers.d/yabai" = {
    text = ''
      %admin ALL=(root) NOPASSWD: ${pkgs.yabai}/bin/yabai --load-sa
    '';
  };

  system.activationScripts.postActivation.text = ''
    echo "Reloading yabai scripting addition after rebuild..."
    sudo ${pkgs.yabai}/bin/yabai --load-sa || true
  '';

  launchd.user.agents.yabai.serviceConfig = {
    KeepAlive = true;
    RunAtLoad = true;
  };
}
