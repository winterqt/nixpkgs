{ lib
, rustPlatform
, fetchFromGitHub
, stdenv
, makeWrapper
, pkg-config
, alsa-lib
, libxkbcommon
, udev
, vulkan-loader
, wayland
, xorg
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "jumpy";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "fishfolk";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-5hgd4t9ZKHmv8wzED7Tn+ykzUM0EbQqRX15HBHzXtJY=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "bevy_ecs_dynamic-0.1.0" = "sha256-2KQViLq7MinO7mUI/FVyj4J4g1dlzrsiVLvZa3X8cIQ=";
      "bevy_ggrs-0.10.0" = "sha256-l/q/fw8dsA1hvwU30Xwv0UE5lqRMwdNoQ3znsIeKvHY=";
      "bevy_hierarchy-0.8.1" = "sha256-ro60kYbyMqILHbXamUPeR/CM1oggJqOMrhnEmtMqwfY=";
      "ggrs-0.9.2" = "sha256-8Oyv9PMo7q0pbPT6OatGaGE/yUgFnvToCg3eqj+FD6Y=";
    };
  };

  auditable = true; # TODO: remove when this is the default

  nativeBuildInputs = [
    makeWrapper
  ] ++ lib.optionals stdenv.isLinux [
    pkg-config
  ];

  buildInputs = lib.optionals stdenv.isLinux [
    alsa-lib
    libxkbcommon
    udev
    vulkan-loader
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Cocoa
    rustPlatform.bindgenHook
  ];

  postPatch = ''
    touch ../$(stripHash $cargoDeps)/taffy/README.md
  '';

  postInstall = ''
    mkdir $out/share
    cp -r assets $out/share
    wrapProgram $out/bin/jumpy \
      --set-default JUMPY_ASSET_DIR $out/share/assets
  '';

  postFixup = lib.optionalString stdenv.isLinux ''
    patchelf $out/bin/.jumpy-wrapped \
      --add-rpath ${lib.makeLibraryPath [ vulkan-loader ]}
  '';

  meta = with lib; {
    description = "A tactical 2D shooter played by up to 4 players online or on a shared screen";
    homepage = "https://fishfight.org/";
    changelog = "https://github.com/fishfolk/jumpy/releases/tag/v${version}";
    license = with licenses; [ mit /* or */ asl20 ];
    maintainers = with maintainers; [ figsoda ];
  };
}
