{ lib, fetchFromGitHub, rustPlatform, git }:

rustPlatform.buildRustPackage rec {
  pname = "gitprompt-rs";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "9ary";
    repo = pname;
    rev = version;
    sha256 = "00xxz7awk01981daabp8m3kwq127y733ynijiwqgs8xvn4nkg8h6";
  };

  cargoLock.lockFile = ./Cargo.lock;

  postPatch = ''
     substituteInPlace src/main.rs \
       --replace 'Command::new("git")' 'Command::new("${git}/bin/git")'
  '';

  meta = with lib; {
    description = "Simple Git prompt";
    homepage = "https://github.com/9ary/gitprompt-rs";
    license = with licenses; [ mpl20 ];
    maintainers = with maintainers; [ novenary ];
  };
}
