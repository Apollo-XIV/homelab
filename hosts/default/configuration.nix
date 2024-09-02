# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
let
  pkl-cli = inputs.pkl.packages.${pkgs.system}.pkl;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./user.nix
      ../../modules/stylix.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.zsh.enable = true;
  networking.hostName = "mishim"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
    

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    nvidiaPersistenced = true;
    open = false;
    powerManagement.finegrained = false; 
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "acrease" = import ./home.nix;
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  user.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-substituters = ["https://ai.cachix.org"];
  nix.settings.trusted-public-keys = ["ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="];
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  # services.xserver = {
    # layout = "gb";
    # xkbVariant = "";
  # };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  security.polkit.enable = true;
  

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable tailscale
  services.tailscale.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
  # nixpkgs.config.packageOverrides = pkgs: {
  #   nur = import (builtins.fetchTarball {
  #     url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
  #     sha256 = "0b3xg1b7v14bkmhpjp56f0j7ghjmb25mq4m7qjawwdyyk67ys22p";
  #   }) {
  #     inherit pkgs;
  #   };
  # };

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "acrease";
    };
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "clairvoyance";
      autoNumlock = true;
    };
  };

  services.xserver.enable = true;

  qt = {
    style = "Adwaita-dark";
    platformTheme = "qt5ct";
  };
  # gtk = {
  #   theme = {
  #     name = "Adwaita-dark";
  #     package = pkgs.gnome.adwaita-gtk-theme;
  #   };
  # };


  environment.variables = {
    GTK_THEME = "Adwaita-dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    KVANTUM_DEFAULT_THEME = "KvAdaptaDark";
  };

  environment.sessionVariables = {
    EDITOR = "hx";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    # LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.steam
    pkgs.helix
    pkgs.git
    pkgs.kitty
    pkgs.zellij    
    pkgs.rofi-wayland
    pkgs.dunst
    pkgs.gimp
    pkgs.mypy
    pkgs.pinta
    pkgs.libnotify
    pkgs.swww
    pkgs.obsidian
    pkgs.waybar
    pkgs.networkmanagerapplet
    pkgs.starship
    pkgs.lsix
    pkgs.hyprpaper
    pkgs.bat
    pkgs.eza
    pkgs.zsh
    pkgs.kodi-wayland
    pkgs.python3
    pkgs.python311Packages.pip
    pkgs.python311Packages.python-lsp-server
    pkgs.python311Packages.ipykernel
    pkgs.python311Packages.jupyter-console
    pkgs.python311Packages.notebook
    pkgs.python311Packages.qtconsole
    pkgs.terraform
    pkgs.terraform-ls
    pkgs.spotify
    pkgs.teams-for-linux
    pkgs.vscode-langservers-extracted
    pkgs.wget
    pkgs.grim
    pkgs.feh
    pkgs.pinta
    pkgs.wl-clipboard
    pkgs.jq
    pkgs.slurp
    pkgs.libnotify
    pkgs.yazi
    pkgs.lynx
    pkgs.vitetris
    pkgs.gh
    pkgs.transmission
    pkgs.btop
    pkgs.cozy
    pkgs.musikcube
    pkgs.nh
    pkgs.lutris
    pkgs.pavucontrol
    pkgs.pulseaudio
    pkgs.playerctl
    pkgs.transmission
    pkgs.coreutils
    pkgs.findutils
    pkgs.xdg-utils
    pkgs.sqlite
    pkgs.tailscale-systray
    pkgs.awscli2
    pkgs.godot_4
    pkgs.ollama
    pkgs.vscode
    pkgs.jupyter-all
    pkgs.vscode-extensions.ms-toolsai.jupyter
    pkgs.unzip
    pkgs.reaper
    pkgs.gcc
    pkgs.libgcc
    pkgs.busybox
    pkgs.protontricks
    pkgs.obs-studio
    pkgs.mpv
    pkgs.wlogout
    pkgs.slack
    pkgs.docker
    pkgs.libsForQt5.qt5ct
    pkgs.kdePackages.partitionmanager
    pkgs.polkit-kde-agent
    pkgs.exercism
    pkgs.go
    pkgs.kubectl
    pkgs.blender
    pkgs.k9s
    pkgs.kubernetes-helm
    pkgs.gnumeric
    pkgs.parsec-bin
    pkgs.moonlight-qt
    pkgs.sunshine
    pkgs.gnome3.adwaita-icon-theme
    pkgs.brave
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-gtk
    pkgs.onlyoffice-bin
    pkgs.nil
    pkgs.yaml-language-server
    pkl-cli
  ];


  services.k3s = {
    enable = true;
    configPath = /home/acrease/.kube/config;
    # clusterInit = true;
    extraFlags = "--write-kubeconfig-mode 0644";
  };


  xdg = {
    mime.defaultApplications = {
      "text/html" = "firefox.desktop";
      "application/pdf" = "firefox.desktop";
      "image/*" = "gimp.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
    portal = {
      enable = true;
      config = {
        common.default = "*";
      };
      extraPortals = with pkgs; [ 
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };

  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];

  # services.openvpn.servers = {
  #   office.config = '' config '';
  # }

  services.sunshine = {
    enable = true;
    openFirewall = true;
  };

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    rootless.enable = true;
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.nameservers = [ "192.168.1.205" ];
  networking.firewall.allowedTCPPorts = [ 9090 ];
  networking.firewall.allowedUDPPorts = [ 9090 ];
  # services.resolved = {
    # enable = true;
    # fallbackDns = ["192.168.1.205"];
  # };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
