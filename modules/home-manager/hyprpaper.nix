{ lib, config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [
        "/home/acrease/Documents/homelab/assets/dark_nature.jpg"
      ]
      wallpaper = [
        "HDMI-A-1, /home/acrease/Documents/homelab/assets/dark_nature.jpg"
        "DP-1, /home/acrease/Documents/homelab/assets/dark_nature.jpg"
      ];
    };
  };
}
