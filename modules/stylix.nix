{lib, config, pkgs, ...}:

{
  stylix = {
    enable = true;
    autoEnable = true;
    image = /home/acrease/Documents/homelab/assets/dark_nature.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.fira-code-nerdfont;
        name = "FiraCode Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
