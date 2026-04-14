{ config, pkgs, unstablePkgs, ... }:

{
  home.username = "reach";
  home.homeDirectory = "/var/home/reach";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11";

  home.packages = [
    unstablePkgs.neovim
    pkgs.gnumake
    pkgs.bluebuild
    pkgs.dive
    pkgs.fx
    pkgs.bat
  ];

  home.file = {
    ".inputrc".source = dotfiles/.inputrc;
    #".bashrc".source = dotfiles/.bashrc;
    ".local/bin/vpn-fzf".source = dotfiles/.local/bin/vpn-fzf;
  };

  xdg.configFile = {
    "tmux/tmux.conf".source = dotfiles/.config/tmux/tmux.conf;
    "tmux/tokyonight_storm.tmux".source = dotfiles/.config/tmux/tokyonight_storm.tmux;
    "ghostty/config".source = dotfiles/.config/ghostty/config;
    "ghostty/themes/tokyonight-storm".source = dotfiles/.config/ghostty/themes/tokyonight-storm;
    "hister/config.yaml".source = dotfiles/.config/hister/config.yaml;
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
    ./modules/hister.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
  };
}
