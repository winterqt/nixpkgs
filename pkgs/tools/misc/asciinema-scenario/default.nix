{ lib
, rustPlatform
, fetchCrate
}:

rustPlatform.buildRustPackage rec {
  pname = "asciinema-scenario";
  version = "0.3.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-fnX5CIYLdFqi04PQPVIAYDGn+xXi016l8pPcIrYIhmQ=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Create asciinema videos from a text file";
    homepage = "https://github.com/garbas/asciinema-scenario/";
    maintainers = with maintainers; [ garbas ];
    license = with licenses; [ mit ];
  };
}
