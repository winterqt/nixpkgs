{ lib
, fetchCrate
, rustPlatform
, pkg-config
, openssl
, dbus
, sqlite
, stdenv
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "leetcode-cli";
  version = "0.3.11";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-DHtIhiRPRGuO6Rf1d9f8r0bMOHqAaJleUvYNyPiX6mc=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
    dbus
    sqlite
  ] ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Security ];

  meta = with lib; {
    description = "May the code be with you 👻";
    longDescription = "Use leetcode.com in command line";
    homepage = "https://github.com/clearloop/leetcode-cli";
    license = licenses.mit;
    maintainers = with maintainers; [ congee ];
    mainProgram = "leetcode";
  };
}
