{ lib, rustPlatform, fetchCrate, installShellFiles, perl }:

rustPlatform.buildRustPackage rec {
  pname = "teip";
  version = "2.0.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-fME+tS8wcC6mk5FjuDJpFWWhIsiXV4kuybSqj9awFUM=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ installShellFiles ];

  nativeCheckInputs = [ perl ];

  postInstall = ''
    installManPage man/teip.1
    installShellCompletion --zsh completion/zsh/_teip
  '';

  meta = with lib; {
    description = "A tool to bypass a partial range of standard input to any command";
    homepage = "https://github.com/greymd/teip";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
  };
}
