{ lib, rustPlatform, fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "mandown";
  version = "0.1.3";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-8a4sImsjw+lzeVK4V74VpIKDcAhMR1bOmJYVWzfWEfc=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Markdown to groff (man page) converter";
    homepage = "https://gitlab.com/kornelski/mandown";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ ];
  };
}
