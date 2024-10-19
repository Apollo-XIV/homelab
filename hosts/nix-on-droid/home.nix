{ lib, pkgs, ... }:
{
  imports = [
    ../../modules/stylix.nix
  ] ++ map (name: "../../modules/home-manager/${name}") [
    "zsh.nix"
    "helix.nix"
    "zellij.nix"
  ];

  home.username = "acrease";
  home.homeDirectory = "/home/acrease";
  home.stateVersion = "24.05";
  home.packages = [
    pkgs.zoxide
    pkgs.fzf
    (pkgs.writeShellScriptBin "rebuild" ''
      nix-on-droid switch --flake ~/docs/homelab#
    '')

    (pkgs.writeShellScriptBin "gtp" ''
      set -e
      echo "Switching to project $1"
      new_dir=$(zoxide query $1)
      cd $new_dir
      zellij ac new-tab -l ide
    '')
  ];
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "hx";
    config = "~/.config/nixos/";
  };

  programs.home-manager.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = lib.mkForce "TTY";
      theme_background = false;
      vim_keys = true;
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "Apollo-XIV";
        identityFile = "/home/acrease/.ssh/github";
      };
      "bitbucket.org" = {
        hostname = "bitbucket.org";
        user = "alex.crease@jdplc.com";
        identityFile = "/home/acrease/.ssh/bitbucket";
      };
      "salas" = {
        hostname = "192.168.1.205";
        user = "acrease";
        identityFile = "/home/acrease/.ssh/salas";
      };
      "mishim" = {
        hostname = "192.168.1.234";
        user = "acrease";
        identityFile = "/home/acrease/.ssh/salas";
      };
    };
  };
  
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
    };
  };
  
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "alex@crease.sh";
    userName = "acrease";
    extraConfig = {
      credentials = {
        "https://github.com" = {
          username = "Apollo-XIV";
        };
      };
    };
  };

  programs.bash = {
    enable = true;    
  };

  programs.lazygit = {
    enable = true;
    settings = {};
  };
}
