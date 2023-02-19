{ lib, rustPlatform, fetchFromGitea }:

rustPlatform.buildRustPackage rec {
  pname = "seehecht";
  version = "3.0.3";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "annaaurora";
    repo = "seehecht";
    rev = "v${version}";
    sha256 = "sha256-KIxK0JYfq/1Bn4LOn+LzWPBUvGYMvOEuqS7GMpDRvW0=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  postInstall = ''
    ln -s $out/bin/seh $out/bin/seehecht
  '';

  meta = with lib; {
    description = "A tool to quickly open a markdown document with already filled out frontmatter";
    license = licenses.lgpl3Only;
    platforms = platforms.all;
    maintainers = with maintainers; [ annaaurora ];
  };
}
