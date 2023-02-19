{ lib
, rustPlatform
, fetchCrate
}:

rustPlatform.buildRustPackage rec {
  pname = "svlint";
  version = "0.6.1";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-rPgURBjhfCRO7XFtr24Y7Dvcm/VEv7frq8p6wvtgjdY=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  cargoBuildFlags = [ "--bin" "svlint" ];

  meta = with lib; {
    description = "SystemVerilog linter";
    homepage = "https://github.com/dalance/svlint";
    changelog = "https://github.com/dalance/svlint/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ trepetti ];
  };
}
