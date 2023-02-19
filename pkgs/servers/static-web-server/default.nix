{ lib, rustPlatform, fetchFromGitHub, stdenv, darwin }:

rustPlatform.buildRustPackage rec {
  pname = "static-web-server";
  version = "2.14.2";

  src = fetchFromGitHub {
    owner = "static-web-server";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-c+bPe1t7Nhpx5fwwpLYtsuzxleLd4b1SwBFBaySmLOg=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "headers-0.3.8" = "sha256-SwjMIvLZJyShUNvRqprcRmKilBhV5vuY1EmuaTkbwK0=";
      "headers-core-0.2.0" = "sha256-SwjMIvLZJyShUNvRqprcRmKilBhV5vuY1EmuaTkbwK0=";
    };
  };

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  checkFlags = [
    # TODO: investigate why these tests fail
    "--skip=tests::handle_byte_ranges_if_range_too_old"
    "--skip=tests::handle_not_modified"
    "--skip=handle_precondition"
  ];

  meta = with lib; {
    description = "An asynchronus web server for static files-serving";
    homepage = "https://sws.joseluisq.net";
    changelog = "https://github.com/static-web-server/static-web-server/blob/v${version}/CHANGELOG.md";
    license = with licenses; [ mit /* or */ asl20 ];
    maintainers = with maintainers; [ figsoda ];
  };
}
