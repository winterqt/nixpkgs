{ lib
, fetchCrate
, fetchpatch
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "bao";
  version = "0.12.0";

  src = fetchCrate {
    inherit version;
    pname = "${pname}_bin";
    sha256 = "SkplBzor7Fv2+6K8wcTtZwjR66RfLPA/YNNUUHniWpM=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = {
    description = "An implementation of BLAKE3 verified streaming";
    homepage = "https://github.com/oconnor663/bao";
    maintainers = with lib.maintainers; [ amarshall ];
    license = with lib.licenses; [ cc0 asl20 ];
  };
}
