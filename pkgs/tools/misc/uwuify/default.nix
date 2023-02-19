{ lib, stdenv, fetchFromGitHub, rustPlatform, libiconv }:

rustPlatform.buildRustPackage rec {
  pname = "uwuify";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "Daniel-Liu-c0deb0t";
    repo = "uwu";
    rev = "v${version}";
    sha256 = "sha256-MzXObbxccwEG7egmQMCdhUukGqZS+NgbYwZjTaqME7I=";
  };

  cargoLock.lockFile = ./Cargo.lock;
  buildInputs = lib.optionals stdenv.isDarwin [ libiconv ];

  meta = with lib; {
    description = "Fast text uwuifier";
    homepage = "https://github.com/Daniel-Liu-c0deb0t/uwu";
    license = licenses.mit;
    platforms = lib.platforms.x86; # uses SSE instructions
    maintainers = with maintainers; [ siraben ];
  };
}
