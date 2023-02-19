{ lib, fetchCrate, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "license-generator";
  version = "1.0.0";

  src = fetchCrate {
    inherit pname version;
    hash = "sha256-ijA/AqLeQ9/XLeCriWNUA6R3iKyq+QPDH5twSvqFmEA=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Command-line tool for generating license files";
    homepage = "https://github.com/azu/license-generator";
    license = licenses.mit;
    maintainers = with maintainers; [ loicreynier ];
  };
}
