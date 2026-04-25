{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        hashKnownHosts = true;
        serverAliveInterval = 60; # 1m

        controlMaster = "auto";
        controlPath = "~/.ssh/sockets/%r@%h-%p";
        controlPersist = "15m";

        setEnv = {
          TERM = "xterm-256color";
        };
      };

      "f1*r*s* f1b*r*s* f4*r*s* f6*r*s*" = {
        hostname = "%h.paris.42.school";
        user = "reach";
        extraOptions = {
          GSSAPIAuthentication = "yes";
          GSSAPIDelegateCredentials = "yes";
        };
      };

    };
  };
}
