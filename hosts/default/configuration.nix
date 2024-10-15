# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
let
  pkl = inputs.pkl.packages.${pkgs.system}.pkl;
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
  hardware.graphics= {
    enable = true;
    enable32Bit = true;
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
  #     package = pkgs4gnome.adwaita-gtk-theme;
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
  environment.systemPackages = with pkgs; [
    vim
    niv
    steam
    helix
    git
    kitty
    zellij    
    rofi-wayland
    dunst
    gimp
    mypy
    pinta
    libnotify
    swww
    obsidian
    waybar
    networkmanagerapplet
    starship
    lsix
    hyprpaper
    bat
    eza
    zsh
    kodi-wayland
    python3
    python311Packages.pip
    python311Packages.python-lsp-server
    python311Packages.ipykernel
    python311Packages.jupyter-console
    python311Packages.notebook
    python311Packages.qtconsole
    terraform
    terraform-ls
    spotify
    teams-for-linux
    vscode-langservers-extracted
    wget
    grim
    feh
    pinta
    wl-clipboard
    jq
    slurp
    libnotify
    yazi
    lynx
    vitetris
    gh
    transmission_4
    btop
    cozy
    musikcube
    nh
    lutris
    pavucontrol
    pulseaudio
    playerctl
    coreutils
    findutils
    xdg-utils
    sqlite
    tailscale-systray
    awscli2
    godot_4
    # ollama
    ollama-cuda
    oterm
    nextjs-ollama-llm-ui
    vscode
    jupyter-all
    vscode-extensions.ms-toolsai.jupyter
    unzip
    reaper
    gcc
    nmap
    libgcc
    busybox
    protontricks
    obs-studio
    mpv
    wlogout
    slack
    docker
    libsForQt5.qt5ct
    kdePackages.partitionmanager
    kdePackages.dolphin
    polkit-kde-agent
    exercism
    go
    kubectl
    blender
    k9s
    kubernetes-helm
    gnumeric
    parsec-bin
    moonlight-qt
    sunshine
    adwaita-icon-theme
    brave
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    onlyoffice-bin
    nil
    figlet
    winetricks
    ripgrep
    gitbutler
    yaml-language-server
    tailwindcss-language-server
    act
    lampray
    lampw
    erlang
    superhtml
    nodejs
    gleam
    rebar3
    deno
  ] ++ [
    pkl
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

  hardware.nvidia-container-toolkit.enable = true;

  virtualisation = {
    virtualbox = {
      host.enable = true;
      host.enableKvm = true;
      host.addNetworkInterface = false;
    };
    docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune.enable = true;
      rootless.enable = true;
      enableNvidia = true;
    };
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
