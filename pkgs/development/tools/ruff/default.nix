{ lib
, rustPlatform
, fetchFromGitHub
, installShellFiles
, stdenv
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "ruff";
  version = "0.0.244";

  src = fetchFromGitHub {
    owner = "charliermarsh";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-oQBNVs7hoiXNqz5lYq5YNKHfpQ/c8LZAvNvtFqpTM2E=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "libcst-0.1.0" = "sha256-66Td5jnLEEDHgYapsSmxfgIE43T7PSTYRznllIOw81U=";
      "libcst_derive-0.1.0" = "sha256-66Td5jnLEEDHgYapsSmxfgIE43T7PSTYRznllIOw81U=";
      "rustpython-ast-0.2.0" = "sha256-WmiRFT+wzAtS/4W3hClhGxMmT6q/A3B5U5np3SQWkHQ=";
      "rustpython-common-0.2.0" = "sha256-WmiRFT+wzAtS/4W3hClhGxMmT6q/A3B5U5np3SQWkHQ=";
      "rustpython-compiler-core-0.2.0" = "sha256-WmiRFT+wzAtS/4W3hClhGxMmT6q/A3B5U5np3SQWkHQ=";
      "rustpython-parser-0.2.0" = "sha256-WmiRFT+wzAtS/4W3hClhGxMmT6q/A3B5U5np3SQWkHQ=";
    };
  };

  nativeBuildInputs = [
    installShellFiles
  ];

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreServices
  ];

  # building tests fails with `undefined symbols`
  doCheck = false;

  postInstall = ''
    installShellCompletion --cmd ruff \
      --bash <($out/bin/ruff generate-shell-completion bash) \
      --fish <($out/bin/ruff generate-shell-completion fish) \
      --zsh <($out/bin/ruff generate-shell-completion zsh)
  '';

  meta = with lib; {
    description = "An extremely fast Python linter";
    homepage = "https://github.com/charliermarsh/ruff";
    changelog = "https://github.com/charliermarsh/ruff/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
  };
}
