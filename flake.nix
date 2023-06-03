{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {self, flake-utils, nixpkgs}:
  flake-utils.lib.eachDefaultSystem (system: 
    let pkgs = import nixpkgs { inherit system; };
    in { 
      devShell = pkgs.mkShell {
        name = "nvim-lua";
        buildInputs = with pkgs; [ stylua ];
      };
    }
  );
}
