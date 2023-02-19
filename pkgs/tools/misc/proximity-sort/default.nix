{ lib, rustPlatform, fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "proximity-sort";
  version = "1.2.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-So3cvL2F7wfcPVPEBspMLH4f5KSbVQeUKLJve/BXLA4=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Simple command-line utility for sorting inputs by proximity to a path argument";
    homepage = "https://github.com/jonhoo/proximity-sort";
    license = with licenses; [ mit /* or */ asl20 ];
    maintainers = with maintainers; [ figsoda ];
  };
}
