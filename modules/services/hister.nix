{ config, ... }:
{
  services.hister = {
    enable = true;
    configPath = "${config.home.homeDirectory}/.config/hister/config.yaml";
  };
}
