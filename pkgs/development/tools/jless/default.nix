{ lib, fetchFromGitHub, rustPlatform, stdenv, python3, AppKit, libxcb }:

rustPlatform.buildRustPackage rec {
  pname = "jless";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "PaulJuliusMartinez";
    repo = "jless";
    rev = "v${version}";
    sha256 = "sha256-NB/s29M46mVhTsJWFYnBgJjSjUVbfdmuz69VdpVuR7c=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = lib.optionals stdenv.isLinux [ python3 ];

  buildInputs = [ ]
    ++ lib.optionals stdenv.isDarwin [ AppKit ]
    ++ lib.optionals stdenv.isLinux [ libxcb ];

  meta = with lib; {
    description = "A command-line pager for JSON data";
    homepage = "https://jless.io";
    license = licenses.mit;
    maintainers = with maintainers; [ jfchevrette ];
  };
}
