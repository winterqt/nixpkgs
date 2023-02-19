{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "mdbook-pagetoc";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "slowsage";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-SRrlyUkEdC63NbdAv+J9kb5LTCL/GBwMhnUVdTE4nas=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Table of contents for mdbook (in sidebar)";
    homepage = "https://github.com/slowsage/mdbook-pagetoc";
    license = licenses.mit;
    maintainers = with maintainers; [ blaggacao ];
  };
}
