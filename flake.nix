{
    description = "davide's dotfiles";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix = {
            url = "github:nix-community/stylix/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim/nixos-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
    { self, nixpkgs, home-manager, nixvim, stylix, ... }:
    let
        lib = nixpkgs.lib;
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };

        makeSystem = host: users: nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit host users; };
            modules = [
                ./hosts/${host}/configuration.nix
            ];
        };

        makeHome = { user, host }: home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit user host; };
            modules = [
                ./homes/${host}/${user}/home.nix
                nixvim.homeModules.nixvim
                stylix.homeModules.stylix
            ];
        };

        system = "x86_64-linux";
        hosts = {
            "nixos-pc" = [ "davide" ];
            "nixos-laptop" = [ "davide" ];
        };
    in
    {
        nixosConfigurations = lib.mapAttrs (host: users: makeSystem host users) hosts;
        homeConfigurations = lib.foldl' (hostAcc: host:
            hostAcc // lib.foldl' (userAcc: user:
                userAcc // {
                    "${user}@${host}" = makeHome { inherit user host; };
                }
            ) {} (hosts.${host})
        ) {} (builtins.attrNames hosts);
    };
}
