{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "evtx";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "omerbenamram";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-iexSMcD4XHEYeVWWQXQ7VLZwtUQeEkvrLxMXuxYuxts=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  postPatch = ''
    # CLI tests will fail in the sandbox
    rm tests/test_cli_interactive.rs
  '';

  meta = with lib; {
    description = "Parser for the Windows XML Event Log (EVTX) format";
    homepage = "https://github.com/omerbenamram/evtx";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
