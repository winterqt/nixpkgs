{ lib, rustPlatform, fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-license";
  version = "0.5.1";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-M/QGM8jPLrDIoF1TVYDoVcHni1qaRCyZwHlYgia24Ro=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Cargo subcommand to see license of dependencies";
    homepage = "https://github.com/onur/cargo-license";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ basvandijk figsoda ];
  };
}
