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
      theme = "Catppuccin Machhiato";
    };
  };
}
