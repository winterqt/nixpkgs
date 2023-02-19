{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, stdenv
, openssl
, withALSA ? true
, alsa-lib
, withPortAudio ? false
, portaudio
, withPulseAudio ? false
, libpulseaudio
, withRodio ? true
}:

rustPlatform.buildRustPackage rec {
  pname = "librespot";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "librespot-org";
    repo = "librespot";
    rev = "v${version}";
    sha256 = "sha256-DtF6asSlLdC2m/0JTBo4YUx9HgsojpfiqVdqaIwniKA=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ pkg-config ] ++ lib.optionals stdenv.isDarwin [
    rustPlatform.bindgenHook
  ];

  buildInputs = [ openssl ]
    ++ lib.optional withALSA alsa-lib
    ++ lib.optional withPortAudio portaudio
    ++ lib.optional withPulseAudio libpulseaudio;

  buildNoDefaultFeatures = true;
  buildFeatures = lib.optional withRodio "rodio-backend"
    ++ lib.optional withALSA "alsa-backend"
    ++ lib.optional withPortAudio "portaudio-backend"
    ++ lib.optional withPulseAudio "pulseaudio-backend";

  meta = with lib; {
    description = "Open Source Spotify client library and playback daemon";
    homepage = "https://github.com/librespot-org/librespot";
    changelog = "https://github.com/librespot-org/librespot/blob/v${version}/CHANGELOG.md";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ bennofs ];
  };
}
