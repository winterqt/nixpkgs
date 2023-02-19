{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, openssl
, gtk3
, stdenv
, rust
}:

rustPlatform.buildRustPackage rec {
  pname = "effitask";
  version = "1.4.1";

  src = fetchFromGitHub {
    owner = "sanpii";
    repo = pname;
    rev = version;
    sha256 = "sha256-nZn+mINIqAnaCKZCiywG8/BOPx6TlSe0rKV/8gcW/B4=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl gtk3 ];

  # default installPhase don't install assets
  installPhase = ''
    runHook preInstall
    make install PREFIX="$out" TARGET="target/${rust.toRustTarget stdenv.hostPlatform}/release/effitask"
    runHook postInstall
  '';

  meta = with lib; {
    description = "Graphical task manager, based on the todo.txt format";
    longDescription = ''
      To use it as todo.sh add-on, create a symlink like this:
      mkdir ~/.todo.actions.d/
      ln -s $(which effitask) ~/.todo.actions.d/et

      Or use it as standalone program by defining some environment variables
      like described in the projects readme.
    '';
    homepage = "https://github.com/sanpii/effitask";
    maintainers = with maintainers; [ davidak ];
    license = with licenses; [ mit ];
  };
}
