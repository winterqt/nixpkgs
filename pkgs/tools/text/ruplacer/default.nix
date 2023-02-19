{ lib, stdenv, fetchFromGitHub, rustPlatform, Security }:

rustPlatform.buildRustPackage rec {
  pname = "ruplacer";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "TankerHQ";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-7qVjJLw90SUtXkfp40u/X84trnJzgCV6mp7b/yNmcPk=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  buildInputs = (lib.optional stdenv.isDarwin Security);

  meta = with lib; {
    description = "Find and replace text in source files";
    homepage = "https://github.com/TankerHQ/ruplacer";
    license = [ licenses.bsd3 ];
    maintainers = with maintainers; [ Br1ght0ne ];
  };
}
