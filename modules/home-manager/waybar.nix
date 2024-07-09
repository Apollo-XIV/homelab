{ lib, config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        modules-left = [
          "hypr/workspaces"
          "wlr/taskbar"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          ""
        ];
      }
    ];
  };
}
