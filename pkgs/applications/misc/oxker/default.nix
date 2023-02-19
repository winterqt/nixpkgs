{ lib, fetchCrate, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "oxker";
  version = "0.2.3";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-J+3wi1nqkxR3ZDfR+F3rvFjUz1DJ7/jhjmcvFdMzWYc=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A simple tui to view & control docker containers";
    homepage = "https://github.com/mrjackwills/oxker";
    changelog = "https://github.com/mrjackwills/oxker/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ siph ];
  };
}
