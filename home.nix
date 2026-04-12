{ config, pkgs, ... }:

{
  home.username = "reach";
  home.homeDirectory = "/var/home/reach";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11";

  home.packages = [
    pkgs.neovim
    pkgs.gnumake
  ];

  home.file = {
    ".bashrc".source = dotfiles/.bashrc;
    ".config/tmux/tmux.conf".source = dotfiles/.config/tmux/tmux.conf;
    ".config/tmux/tokyonight_storm.tmux".source = dotfiles/.config/tmux/tokyonight_storm.tmux;
    ".config/ghostty/config".source = dotfiles/.config/ghostty/config;
    ".config/ghostty/themes/tokyonight-storm".source = dotfiles/.config/ghostty/themes/tokyonight-storm;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  hostConfig = {
    enable = true;
  
    # Automatically materialize all xdg.desktopEntries as real files
    xdgDesktopEntries = true;
  
    # Any other Home Manager-managed files the host needs to read
    files = [
      ".bashrc"
      ".config/tmux/tmux.conf"
      ".config/tmux/tokyonight_storm.tmux"
      ".config/ghostty/config"
      ".config/ghostty/themes/tokyonight-storm"
    ];
  };
}
