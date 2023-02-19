{ lib
, fetchFromGitHub
, rustPlatform
, makeWrapper
, watchman
}:

rustPlatform.buildRustPackage rec {
  pname = "rs-git-fsmonitor";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "jgavris";
    repo = pname;
    rev = "v${version}";
    sha256 = "021vdk5i7yyrnh4apn0gnsh6ycnx15wm3g2jrfsg7fycnq8167wc";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ makeWrapper ];

  fixupPhase = ''
    wrapProgram $out/bin/rs-git-fsmonitor --prefix PATH ":" "${lib.makeBinPath [ watchman ]}" ;
  '';

  meta = with lib; {
    description = "A fast git core.fsmonitor hook written in Rust";
    homepage = "https://github.com/jgavris/rs-git-fsmonitor";
    license = licenses.mit;
    maintainers = [ maintainers.SuperSandro2000 ];
  };
}
