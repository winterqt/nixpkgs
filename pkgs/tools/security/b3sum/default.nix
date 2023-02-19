{ lib, fetchCrate, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "b3sum";
  version = "1.3.3";

  src = fetchCrate {
    inherit version pname;
    sha256 = "sha256-PeH4oMeLxEM1pKqMsZBhsbmZOAVdLEmWKyPjuRNjowA=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = {
    description = "BLAKE3 cryptographic hash function";
    homepage = "https://github.com/BLAKE3-team/BLAKE3/";
    maintainers = with lib.maintainers; [ fpletz ivan ];
    license = with lib.licenses; [ cc0 asl20 ];
  };
}
