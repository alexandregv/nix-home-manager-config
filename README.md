# Home-Manager (Nix) config and dotfiles

Find the raw dotfiles in [`./dotfiles/`](./dotfiles/).  
I usually prefer the raw config, i.e I use `programs.tmux` to handle the tmux plugins with home-manager, but the config is still a raw tmux.conf.

### Usage

1. Setup standalone nix and home-manager
2. Clone the repo in `~/.config/home-manager`
3. Run `home-manager switch --flake ~/.config/home-manager/`
