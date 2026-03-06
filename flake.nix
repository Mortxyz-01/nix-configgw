
{
  description = "Konfigurasi flake nix ke satu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; 
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Pastikan di baris bawah ini ada kata 'inputs' di dalam kurung kurawal
  outputs = { self, nixpkgs, home-manager, silentSDDM, spicetify-nix, ... } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Sekarang 'inputs' di bawah ini sudah dikenali
      specialArgs = { inherit inputs; }; 
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; }; 
          home-manager.users.gre = import ./home.nix;
        }
        
        silentSDDM.nixosModules.default
        
        {
          programs.silentSDDM = {
            enable = true;
            theme = "rei";
          };
        }
      ];
    };
  };
}
