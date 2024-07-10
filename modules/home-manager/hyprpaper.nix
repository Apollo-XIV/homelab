{ lib, config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [
        "/home/acrease/Documents/homelab/assets/dark_nature.png"
      ];
      wallpaper = [
        "HDMI-A-1, /home/acrease/Documents/homelab/assets/dark_nature.png"
        "DP-1, /home/acrease/Documents/homelab/assets/dark_nature.png"
      ];
    };
  };
}
