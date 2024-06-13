{ lib, config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.acrease = {
      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
        };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        vimium-c
        dashlane
        darkreader
      ];
      bookmarks = [
        {
          name = "youtube";
          tags = ["media"];
          keyword = "youtube";
          url = "www.youtube.com"
        }
        {
          name = "github";
          tags = ["dev"];
          keyword = "git";
          url = "https://github.com"
        }
        {
          name = "nixpkgs";
          tags = ["os"];
          keyword = "nixsearch";
          url = "https://search.nixos.org/packages"
        }
      ];
      userChrome = ''
        
      '';
    };
  };
}
