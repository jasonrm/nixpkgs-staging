{
  description = "dev.mcneil.nix.nixpkgs-staging";

  outputs = { self }: {
    overlay = final: prev: import ./default.nix {
      pkgs = prev;
    };
  };
}
