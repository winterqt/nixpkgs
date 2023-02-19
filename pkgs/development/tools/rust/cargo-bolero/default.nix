{ lib, rustPlatform, fetchCrate, libbfd, libopcodes, libunwind }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-bolero";
  version = "0.8.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-j6fWCIXfVS5b3NZizhg9pI+kJkWlR1eGUSW9hJO1/mQ=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  buildInputs = [ libbfd libopcodes libunwind ];

  meta = with lib; {
    description = "Fuzzing and property testing front-end framework for Rust";
    homepage = "https://github.com/camshaft/bolero";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ ekleog ];
  };
}
