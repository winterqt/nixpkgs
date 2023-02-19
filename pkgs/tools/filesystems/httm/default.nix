{ lib
, rustPlatform
, fetchFromGitHub
, installShellFiles
}:

rustPlatform.buildRustPackage rec {
  pname = "httm";
  version = "0.21.1";

  src = fetchFromGitHub {
    owner = "kimono-koans";
    repo = pname;
    rev = version;
    sha256 = "sha256-uSCFm6aWNPFPcja+KB6TU7iVVYkDdD82pFjA9dOpSs8=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "skim-0.10.2" = "sha256-5bDQZer4r9sNupIilY3afXbyFE1UB8kNsZIFOPmuyu4=";
    };
  };

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installManPage httm.1

    installShellCompletion --cmd httm \
      --zsh scripts/httm-key-bindings.zsh
  '';

  meta = with lib; {
    description = "Interactive, file-level Time Machine-like tool for ZFS/btrfs";
    homepage = "https://github.com/kimono-koans/httm";
    changelog = "https://github.com/kimono-koans/httm/releases/tag/${version}";
    license = licenses.mpl20;
    maintainers = with maintainers; [ wyndon ];
  };
}
