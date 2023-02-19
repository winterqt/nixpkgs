{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, pkg-config
, openssl
, Security
}:

rustPlatform.buildRustPackage rec {
  pname = "twitch-tui";
  version = "2.0.2";

  src = fetchFromGitHub {
    owner = "Xithrius";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-4gEE2JCYNxPOV47w/wMRvYn5YJdgvlYl+fkk6qcXLr8=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    Security
  ];

  meta = with lib; {
    description = "Twitch chat in the terminal";
    homepage = "https://github.com/Xithrius/twitch-tui";
    changelog = "https://github.com/Xithrius/twitch-tui/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = [ maintainers.taha ];
  };
}
