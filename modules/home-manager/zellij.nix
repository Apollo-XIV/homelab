{ lib, config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      copy_command = "wl-copy";
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
      theme = "catppuccin-macchiato";
    };
  };
  home.file = {
    ".config/zellij/layouts/default.kdl".source = "modules/zellij-layouts/default.kdl";
  };
}
