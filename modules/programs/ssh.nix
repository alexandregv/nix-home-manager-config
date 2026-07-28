{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = ["~/.ssh/config_private"];

    settings = {
      "*" = {
        HashKnownHosts = true;
        ServerAliveInterval = 60; # 1m

        ControlMaster = "auto";
        ControlPath = "~/.ssh/sockets/%r@%h-%p";
        ControlPersist = "15m";

        SetEnv = {
          TERM = "xterm-256color";
        };
      };

      "f0*r*s* f1*r*s* f1b*r*s* f2*r*s* f4*r*s* f6*r*s*" = {
        Hostname = "%h.paris.42.school";
        User = "reach";
        GSSAPIAuthentication = "yes";
        GSSAPIDelegateCredentials = "yes";
        StrictHostKeyChecking = "no";
      };

    };
  };
}
