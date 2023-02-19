{ lib, rustPlatform, fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "rust-audit-info";
  version = "0.5.2";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-g7ElNehBAVSRRlqsxkNm20C0KOMkf310bXNs3EN+/NQ=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A command-line tool to extract the dependency trees embedded in binaries by cargo-auditable";
    homepage = "https://github.com/rust-secure-code/cargo-auditable/tree/master/rust-audit-info";
    license = with licenses; [ mit /* or */ asl20 ];
    maintainers = with maintainers; [ figsoda ];
  };
}
