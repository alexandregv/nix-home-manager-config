{ config, pkgs, unstablePkgs, ... }:

{
  home.username = "reach";
  home.homeDirectory = "/var/home/reach";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11";

  home.keyboard = {
    layout = "us";
    variant = "altgr-intl";
  };

  home.packages = [
    unstablePkgs.neovim
    pkgs.gnumake
    pkgs.bluebuild
    pkgs.dive
    pkgs.fx
    pkgs.bat
    pkgs.ncdu
    pkgs.extract_url
    pkgs.k3d
    pkgs.kubectl
    pkgs.gdb
  ];

  home.file = {
    ".inputrc".source = dotfiles/.inputrc;
    #".bashrc".source = dotfiles/.bashrc;
    ".local/bin/vpn-fzf".source = dotfiles/.local/bin/vpn-fzf;
    ".urlview".source = dotfiles/.urlview;
  };

  xdg.configFile = {
    "tmux/tokyonight_storm.tmux".source = dotfiles/.config/tmux/tokyonight_storm.tmux;
    "ghostty/config".source = dotfiles/.config/ghostty/config;
    "ghostty/themes/tokyonight-storm".source = dotfiles/.config/ghostty/themes/tokyonight-storm;
    "hister/config.yaml".source = dotfiles/.config/hister/config.yaml;
    "gdb/gdbearlyinit".source = dotfiles/.config/gdb/gdbearlyinit;
    "gdb/gdbinit".source = dotfiles/.config/gdb/gdbinit;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "nvim";
    FIGNORE = ":.lock:.sum";
  };

  imports = [
    ./modules/services/hister.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
  };

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

  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      filter_mode = "global";
      style = "full";
      inline_height = 0;
    };
  };

  programs.tmux = {
    enable = true;

    plugins = [
      pkgs.tmuxPlugins.resurrect
      pkgs.tmuxPlugins.open
      pkgs.tmuxPlugins.urlview
    ];

    extraConfig = builtins.readFile ./dotfiles/.config/tmux/tmux.conf;
  };
}
