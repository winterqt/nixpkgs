{
  rustPlatform,
  fetchFromGitHub,
  lib,
}:
rustPlatform.buildRustPackage rec {
  pname = "lls";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "jcaesar";
    repo = "lls";
    rev = "v${version}";
    hash = "sha256-Aq0MGhzSoJCkM0Wt/r5JSOz96LyRSgSryD7+m4aFZEA=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Tool to list listening sockets";
    license = licenses.mit;
    maintainers = [ maintainers.k900 ];
    platforms = platforms.linux;
    homepage = "https://github.com/jcaesar/lls";
  };
}
