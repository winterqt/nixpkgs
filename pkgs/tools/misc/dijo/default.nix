{ stdenv, lib, rustPlatform, fetchFromGitHub, ncurses, CoreServices }:

rustPlatform.buildRustPackage rec {
  pname = "dijo";
  version = "0.2.7";
  buildInputs = [ ncurses ] ++ lib.optional stdenv.isDarwin CoreServices;
  src = fetchFromGitHub {
    owner = "NerdyPepper";
    repo = "dijo";
    rev = "v${version}";
    sha256 = "sha256-g+A8BJxqoAvm9LTLrLnClVGtFJCQ2gT0mDGAov/6vXE=";
  };
  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Scriptable, curses-based, digital habit tracker";
    homepage = "https://github.com/NerdyPepper/dijo";
    license = licenses.mit;
    maintainers = with maintainers; [ infinisil ];
  };
}
