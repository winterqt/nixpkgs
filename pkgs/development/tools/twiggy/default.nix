{ lib
, fetchCrate
, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "twiggy";
  version = "0.7.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-NbtS7A5Zl8634Q3xyjVzNraNszjt1uIXqmctArfnqkk=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    homepage = "https://rustwasm.github.io/twiggy/";
    description = "A code size profiler for Wasm";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ lucperkins ];
  };
}
