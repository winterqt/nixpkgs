{ lib, rustPlatform, fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-depgraph";
  version = "1.4.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-D8g6xsmYvN1IWUFpkpo4/OKT70WqCCkRqcGFBOE8uXA=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Create dependency graphs for cargo projects using `cargo metadata` and graphviz";
    homepage = "https://sr.ht/~jplatte/cargo-depgraph";
    changelog = "https://git.sr.ht/~jplatte/cargo-depgraph/tree/v${version}/item/CHANGELOG.md";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ figsoda ];
  };
}
