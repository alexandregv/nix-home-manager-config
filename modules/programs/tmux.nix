{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    plugins = [
      pkgs.tmuxPlugins.resurrect
      pkgs.tmuxPlugins.open
      pkgs.tmuxPlugins.urlview
    ];

    extraConfig = builtins.readFile ../../dotfiles/.config/tmux/tmux.conf;
  };
}
