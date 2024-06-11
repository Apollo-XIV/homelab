{ config, pkgs, inputs, hyprland, ... }:

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

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "rebuild" ''
      git -C ~/.config/nixos/ add .
      git -C ~/.config/nixos/ commit
      sudo nixos-rebuild switch --flake ~/.config/nixos#default && \
      git -C ~/.config/nixos/ push
    '')
  ];

  programs.ncspot = {
    enable = true;
    settings = {}; # toml config file
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "Apollo-XIV";
        identityFile = "/home/acrease/.ssh/github";
      };
    };
  };

  programs.firefox = {
    enable = true;
    profiles.acrease = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        vimium-c
        dashlane
        darkreader
      ];
    };
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      "$menu" = "rofi -show drun ssh";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      monitor = [
        "HDMI-A-1, 1920x1080, 0x0, 1"
        "DP-1, 2560x1080, 1920x500, 1"
      ];

      exec-once = "waybar &";
      
      input = {
        kb_layout = "gb";
      };
      general = {
        gaps_in = 5;
        gaps_out= 8;
        border_size = 1;
        layout = "dwindle";
      };

      decoration = {
        rounding = 8;
        active_opacity = 0.99;
        inactive_opacity = 0.95;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        blur = {
          enabled = true;
          size = 4;
          passes = 1;
          vibrancy = 0.1696;
        };
        "col.shadow" = "rgba(1a1a1aee)";
      };

      bind = [
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, H, movefocus, l"
        "$mainMod, J, movefocus, d"
        # See https://wiki.hyprland.org/Configuring/Keywords/

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo, # dwindle"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod TAB, , workspace, e+1"
        "$mainMod SHIFT TAB, , workspace, e-1"

      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
  programs.hyprlock.enable = true;

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [];
    settings = {
      theme = "kanagawa";
      editor = {
        rulers = [80 120];
        line-number = "relative";
        bufferline = "multiple";
        cursorline = true;
        cursorcolumn = true;
        file-picker.hidden = false;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        lsp = {
          auto-signature-help = false;
          display-messages = false;
        };
        statusline = {
          left = ["mode" "spinner" "version-control" "file-name"];
        };
      };
      keys.normal = {
        "A-," = "goto_previous_buffer";
        "A-." = "goto_next_buffer";
        "A-w" = ":buffer-close";
      };
      keys.insert = {
        j = { k = "normal_mode"; };
      };
    };
  };

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

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
