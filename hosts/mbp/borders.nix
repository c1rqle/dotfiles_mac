{ user, ... }:
{
  launchd.user.agents.borders = {
    command = "/bin/bash -lc /Users/${user}/.config/borders/bordersrc";
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
    };
  };
}
