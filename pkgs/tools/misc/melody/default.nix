{ lib, stdenv, fetchCrate, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "melody";
  version = "0.18.1";

  src = fetchCrate {
    pname = "melody_cli";
    inherit version;
    sha256 = "sha256-Az1pGRty7wAC5fN7RlO/etaW5w5TrsO6VVXv5M7NUfU=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Language that compiles to regular expressions";
    homepage = "https://github.com/yoav-lavi/melody";
    license = licenses.mit;
    maintainers = with maintainers; [ joelkoen ];
  };
}
