{ lib, config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    environment = {
      "EDITOR" = "hx";
    };
    font.name = "FiraCode-Retina";
    font.package = pkgs.fira-code;
    shellIntegration.enableZshIntegration = true;
    theme = "Aquarium Dark";
    settings = {
      font_features = "FiraCode-Retina +zero +onum";
      cursor_shape = "beam";
      window_margin_width = 10;
    };
  };


}
