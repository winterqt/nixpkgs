{ lib, fetchCrate, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-deps";
  version = "1.5.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-0zK1qwu+awZGd9hgH2WRrzJMzwpI830Lh//P0wVp6Js=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Cargo subcommand for building dependency graphs of Rust projects";
    homepage = "https://github.com/m-cat/cargo-deps";
    license = licenses.mit;
    maintainers = with maintainers; [ arcnmx ];
  };
}
