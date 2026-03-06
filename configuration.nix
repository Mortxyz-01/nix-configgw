{ config, pkgs, ... }:

{
  # ==================================================
  # Imports
  # ==================================================
  imports = [
    ./hardware-configuration.nix
  ];

  # ==================================================
  # Nix Settings
  # ==================================================
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # ==================================================
  # Bootloader
  # ==================================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # ==================================================
  # Networking
  # ==================================================
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ==================================================
  # Time & Locale
  # ==================================================
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ==================================================
  # Hardware & Graphics
  # ==================================================
  hardware.enableAllFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # true = nvidia-open (Turing+)
    # false = proprietary
    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # ==================================================
  # Power Management
  # ==================================================
    services.tlp = {
    enable = true;
    settings = {
    START_CHARGE_THRESH_BAT0 = 40; # Start charging at 40%
    STOP_CHARGE_THRESH_BAT0 = 80;  # Stop charging at 80%
   };
  };
  # ==================================================
  # Audio (PipeWire)
  # ==================================================
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # ==================================================
  # Wayland / Hyprland
  # ==================================================
  programs.hyprland.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # ==================================================
  # User
  # ==================================================
  users.users.gre = {
    isNormalUser = true;
    description = "gre";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  # ==================================================
  # System Packages
  # ==================================================
  environment.systemPackages = with pkgs; [
    mpv
    fastfetch
    kitty
    hyfetch
    git
    gedit
    fish
    swww
    cava
    wlogout
    vscode
    kew
    btop
    firefox
    yazi
    grim
    wl-clipboard
    slurp
    sof-firmware
    alsa-ucm-conf
    pulseaudio
    alsa-utils
    pavucontrol
    vlc
    nautilus
    udiskie
    gparted
    brave
    nodejs
    ghidra  
    ];

  # ==================================================
  # Fonts
  # ==================================================
fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-color-emoji
  font-awesome
  nerd-fonts.fira-code
   jetbrains-mono  
  nerd-fonts.jetbrains-mono
];

  # ==================================================
  # Extra Services
  # ==================================================
  services.flatpak.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # ==================================================
  # System Version
  # ==================================================
  system.stateVersion = "25.11";
 
  services.udisks2.enable = true;
  programs.niri.enable = true;
  services.asusd.enable = true;
 }
