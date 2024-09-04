{ lib, config, pkgs, inputs, hyprland, ... }:

# let
#   nur-pkgs = import (builtins.fetchTarball  {
#     url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
#     sha256 = "0b3xg1b7v14bkmhpjp56f0j7ghjmb25mq4m7qjawwdyyk67ys22p";
#   }) {};

# in
let
  nurNoPkgs = import inputs.nur { pkgs = null; nurpkgs = pkgs; };
        # hyprland.homeManagerModules.default
in
{
  imports = [
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/helix.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/hyprpaper.nix
    ../../modules/home-manager/zellij.nix
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/hyprlock.nix
    ../../modules/home-manager/wlogout.nix
    ../../modules/stylix.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "acrease";
  home.homeDirectory = "/home/acrease";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.discord
    pkgs.zoxide
    pkgs.fzf
    pkgs.mp3blaster

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # Rebuild command makes sure the current changes are on the exp branch and
    # then commits and pushes it before rebuilding the system
    (pkgs.writeShellScriptBin "rebuild" ''
      current_branch=$(git -C ~/Documents/homelab/ symbolic-ref --short HEAD)
      if [ "$current_branch" != "exp" ]; then
        echo "Not on exp branch, switching to exp"
        git -C ~/Documents/homelab/ checkout exp
      fi
      git -C ~/Documents/homelab/ add .
      git -C ~/Documents/homelab/ commit -m "Automatic commit on exp branch"
      sudo nixos-rebuild switch --flake ~/Documents/homelab#default && \
      git -C ~/Documents/homelab/ push origin exp
    '')

    # takes currently committed stuff on the exp branch, squashes it into one 
    # commit, promtps the user for a commit message, and ff-merges it into main
    # before pushing
    (pkgs.writeShellScriptBin "approve" ''
      git -C ~/Documents/homelab/ checkout main
      git -C ~/Documents/homelab/ merge --squash exp
      git -C ~/Documents/homelab/ commit
      git -C ~/Documents/homelab/ push origin main
      git -C ~/Documents/homelab/ checkout exp
    '')
  ];

  programs.ncspot = {
    enable = true;
    settings = {}; # toml config file
  };

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
        hostname = "192.168.1.50";
        user = "acrease";
        identityFile = "/home/acrease/.ssh/salas";
        extraOptions = {
          KexAlgorithms = "+diffie-hellman-group1-sha1";
          HostKeyAlgorithms = "ssh-dss";
        };
      };
      "mishim" = {
        hostname = "192.168.1.234";
        user = "acrease";
        identityFile = "/home/acrease/.ssh/salas";
      };
    };
  };

  
  programs.hyprlock.enable = true;


  programs.starship = {
    enable = true;
    enableZshIntegration = true;
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

  programs.lazygit = {
    enable = true;
    settings = {};
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    "utils/generate-keys.py" = {
      enable = true;
      executable = true;
      source = ../../assets/generate-keys.py;
    };
    "utils.sh" = {
      enable = true;
      executable = true;
      source = ../../assets/utils.sh;
    };
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/*" = "firefox.desktop";
      "image/png" = "firefox.desktop";
      "image/jpg" = "firefox.desktop";
    };
  };


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/acrease/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "hx";
    config = "~/.config/nixos/";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
