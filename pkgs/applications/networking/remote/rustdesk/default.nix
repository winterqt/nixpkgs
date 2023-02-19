{ lib
, stdenv
, fetchFromGitHub
, makeDesktopItem
, copyDesktopItems
, makeWrapper
, rustPlatform
, cmake
, yasm
, nasm
, zip
, pkg-config
, clang
, gtk3
, xdotool
, libxcb
, libXfixes
, alsa-lib
, pulseaudio
, libXtst
, libvpx
, libyuv
, libopus
, libsciter
, llvmPackages
, wrapGAppsHook
, writeText
}:

rustPlatform.buildRustPackage rec {
  pname = "rustdesk";
  version = "1.1.9";

  src = fetchFromGitHub {
    owner = "rustdesk";
    repo = "rustdesk";
    rev = version;
    sha256 = "sha256-IlrfqwNyaSHE9Ct0mn7MUxEg7p1Ku34eOMYelEAYFW8=";
  };

  patches = [
    # based on https://github.com/rustdesk/rustdesk/pull/1900
    ./fix-for-rust-1.65.diff
  ];

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "confy-0.4.0" = "sha256-e91cvEixhpPzIthAxzTa3fDY6eCsHUy/eZQAqs7QTDo=";
      "libappindicator-0.6.1" = "sha256-JGnnZrcwbh8WJ6+/4bYhfD3HvgF2C7XaaGb6TaMRWdw=";
      "libappindicator-sys-0.6.1" = "sha256-JGnnZrcwbh8WJ6+/4bYhfD3HvgF2C7XaaGb6TaMRWdw=";
      "magnum-opus-0.4.0" = "sha256-GoCuStsQW/M6PEfdtbJ69ePNAL8bQ9HIJVopv+k93nY=";
      "parity-tokio-ipc-0.7.3" = "sha256-Ji/q7RQDznFs+m4AHH1IEL1TMqqCtH4Z5DY6sjcu/T0=";
      "rdev-0.5.0" = "sha256-O+jbA8GS9KVZR/i840+mfQ9LZ3Qtf/XBbV/Mkqn5C/g=";
      "rust-pulsectl-0.2.12" = "sha256-8jXTspWvjONFcvw9/Z8C43g4BuGZ3rsG32tvLMQbtbM=";
      "sciter-rs-0.5.57" = "sha256-ZZnZDhMjK0LjgmK0da1yvB0uoKueLhhhQtzmjoN+1R0=";
      "systray-0.4.1" = "sha256-p1PMr/8oS6zHx4+Ng4zCqt0xZ57cq3wAu6/agyWq5Jw=";
      "tokio-socks-0.5.1" = "sha256-inmAJk0fAlsVNIwfD/M+htwIdQHwGSTRrEy6N/mspMI=";
    };
  };

  LIBCLANG_PATH="${llvmPackages.libclang.lib}/lib";

  # Change magnus-opus version to upstream so that it does not use
  # vcpkg for libopus since it does not work.
  cargoPatches = [
    ./cargo.patch
  ];

  # Manually simulate a vcpkg installation so that it can link the libaries
  # properly.
  postUnpack = let
    vcpkg_target = "x64-linux";

    updates_vcpkg_file = writeText "update_vcpkg_rustdesk"
    ''
    Package : libyuv
    Architecture : ${vcpkg_target}
    Version : 1.0
    Status : is installed

    Package : libvpx
    Architecture : ${vcpkg_target}
    Version : 1.0
    Status : is installed
    '';
  in ''
    export VCPKG_ROOT="$TMP/vcpkg";

    mkdir -p $VCPKG_ROOT/.vcpkg-root
    mkdir -p $VCPKG_ROOT/installed/${vcpkg_target}/lib
    mkdir -p $VCPKG_ROOT/installed/vcpkg/updates
    ln -s ${updates_vcpkg_file} $VCPKG_ROOT/installed/vcpkg/status
    mkdir -p $VCPKG_ROOT/installed/vcpkg/info
    touch $VCPKG_ROOT/installed/vcpkg/info/libyuv_1.0_${vcpkg_target}.list
    touch $VCPKG_ROOT/installed/vcpkg/info/libvpx_1.0_${vcpkg_target}.list

    ln -s ${libvpx.out}/lib/* $VCPKG_ROOT/installed/${vcpkg_target}/lib/
    ln -s ${libyuv.out}/lib/* $VCPKG_ROOT/installed/${vcpkg_target}/lib/
  '';

  nativeBuildInputs = [ pkg-config cmake makeWrapper copyDesktopItems yasm nasm clang wrapGAppsHook ];
  buildInputs = [ alsa-lib pulseaudio libXfixes libxcb xdotool gtk3 libvpx libopus libXtst libyuv ];

  # Checks require an active X display.
  doCheck = false;

  desktopItems = [ (makeDesktopItem {
    name = "rustdesk";
    exec = meta.mainProgram;
    icon = "rustdesk";
    desktopName = "RustDesk";
    comment = meta.description;
    genericName = "Remote Desktop";
    categories = ["Network"];
  }) ];

  # Add static ui resources and libsciter to same folder as binary so that it
  # can find them.
  postInstall = ''
    mkdir -p $out/{share/src,lib/rustdesk}

    # so needs to be next to the executable
    mv $out/bin/rustdesk $out/lib/rustdesk
    ln -s ${libsciter}/lib/libsciter-gtk.so $out/lib/rustdesk

    makeWrapper $out/lib/rustdesk/rustdesk $out/bin/rustdesk \
      --chdir "$out/share"

    cp -a $src/src/ui $out/share/src

    install -Dm0644 $src/logo.svg $out/share/icons/hicolor/scalable/apps/rustdesk.svg
  '';

  meta = with lib; {
    description = "Yet another remote desktop software";
    homepage = "https://rustdesk.com";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ leixb ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "rustdesk";
  };
}
