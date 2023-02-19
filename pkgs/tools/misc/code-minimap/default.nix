{ lib
, stdenv
, rustPlatform
, fetchFromGitHub
, libiconv
}:

rustPlatform.buildRustPackage rec {
  pname = "code-minimap";
  version = "0.6.4";

  src = fetchFromGitHub {
    owner = "wfxr";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-XhewfU3l/n2wiF9pKm1OOKQ7REzz3WzcBiVgOiYnAYU=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  buildInputs = lib.optional stdenv.isDarwin libiconv;

  meta = with lib; {
    description = "A high performance code minimap render";
    homepage = "https://github.com/wfxr/code-minimap";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ bsima ];
  };
}
