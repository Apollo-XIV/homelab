{ lib, config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [
      {
        height = 30;
        spacing = 4;
        modules-left = [
          "hypr/workspaces"
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
