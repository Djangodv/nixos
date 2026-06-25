{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-26.05 branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

		nixvirt = {
			url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = { self, nixpkgs, nixvirt, ... }@inputs:
    let
      # Define system specific variables for the NixOS configuration
      cfg = {
        username = "user";
        hostname = "nixos-demo";
        secondaryDrive = "/data";
        projectRoot = "/home/${cfg.username}/Github/nixos";
      };
    in
    {
    nixosConfigurations.nixos-demo = nixpkgs.lib.nixosSystem {
      # Let configuration.nix inherit inputs to use in configuration
      specialArgs = { inherit inputs; inherit cfg; };
      modules = [

				nixvirt.nixosModules.default

        ./nixos/configuration.nix
				./devshell.nix

      ];
    };
  };
}
