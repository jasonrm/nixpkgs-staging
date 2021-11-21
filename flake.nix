{
  description = "dev.mcneil.nix.nixpkgs-staging";

  outputs = { self }: {
    overlay = final: prev: {
      staging = import ./default.nix {
        pkgs = prev;
      };
    };
  };
}
