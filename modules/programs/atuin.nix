{ ... }:
{
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      filter_mode = "global";
      style = "full";
      inline_height = 0;
    };
  };
}
