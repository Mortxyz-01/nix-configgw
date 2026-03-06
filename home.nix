{ config, pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  home.username = "gre";
  home.homeDirectory = "/home/gre";
  home.stateVersion = "25.11"; 

# Ganti yang lama dengan ini:
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];
  # Mengizinkan software unfree (Spotify)
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    firefox
    git
    vesktop
    fastfetch
    hyfetch
    
    # Wayland stuff
    waybar
    mako
    swww
    fuzzel
    wl-clipboard
    xwayland-satellite
    rofi
    hyprpaper
    nix-tree    
    alacritty
    polkit_gnome
    antigravity
    brightnessctl  
    python3
];

  # 2. Konfigurasi Spicetify
  programs.spicetify = {
    enable = true;
    
    # Tema & Warna
    theme = spicePkgs.themes.comfy;
    colorScheme = "rose-pine";

    # Ekstensi yang diaktifkan
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    
    # Apps tambahan (opsional, sangat disarankan)
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      lyricsPlus
    ];
  };

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  programs.git = { 
    enable = true;
    userName = "gre111";
    userEmail = "windowqea@gmail.com";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    };
  };

  programs.home-manager.enable = true;
}
