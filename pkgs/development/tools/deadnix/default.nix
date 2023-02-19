{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "deadnix";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "astro";
    repo = "deadnix";
    rev = "v${version}";
    sha256 = "sha256-T8VwxHdy5KI2Kob5wYWGQOGYYJeSfWVPygIOe0PYUMY=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Find and remove unused code in .nix source files";
    homepage = "https://github.com/astro/deadnix";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ astro ];
  };
}
