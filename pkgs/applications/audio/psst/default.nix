{ lib, fetchFromGitHub, rustPlatform, alsa-lib, atk, cairo, dbus, gdk-pixbuf, glib, gtk3, pango, pkg-config, makeDesktopItem }:

let
  desktopItem = makeDesktopItem {
    name = "Psst";
    exec = "psst-gui";
    comment = "Fast and multi-platform Spotify client with native GUI";
    desktopName = "Psst";
    type = "Application";
    categories = [ "Audio" "AudioVideo" ];
    icon = "psst";
    terminal = false;
  };

in
rustPlatform.buildRustPackage rec {
  pname = "psst";
  version = "unstable-2022-10-13";

  src = fetchFromGitHub {
    owner = "jpochyla";
    repo = pname;
    rev = "d70ed8104533dc15bc36b989ba8428872c9b578f";
    hash = "sha256-ZKhHN0ruLb6ZVKkrKv/YawRsVop6SP1QF/nrtkmA8P8=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "cubeb-0.10.1" = "sha256-7y43N7LXw3OpYSh2B+Lh3iPHXxmDxmvzquOs94S5G5s=";
      "cubeb-core-0.10.1" = "sha256-7y43N7LXw3OpYSh2B+Lh3iPHXxmDxmvzquOs94S5G5s=";
      "cubeb-sys-0.10.1" = "sha256-7y43N7LXw3OpYSh2B+Lh3iPHXxmDxmvzquOs94S5G5s=";
      "druid-0.7.0" = "sha256-fnsm+KGsuePLRRjTecJ0GBQEySSeDIth13AX/aAigqU=";
      "druid-derive-0.4.0" = "sha256-fnsm+KGsuePLRRjTecJ0GBQEySSeDIth13AX/aAigqU=";
      "druid-enums-0.1.0" = "sha256-4fo0ywoK+m4OuqYlbNbJS2BZK/VBFqeAYEFNGnGUVmM=";
      "druid-shell-0.7.0" = "sha256-fnsm+KGsuePLRRjTecJ0GBQEySSeDIth13AX/aAigqU=";
      "piet-0.5.0" = "sha256-u+3UCSZQDkftHCN7AW0mUROY/yVTgPOcrF+b3Si/2BQ=";
      "piet-cairo-0.5.0" = "sha256-u+3UCSZQDkftHCN7AW0mUROY/yVTgPOcrF+b3Si/2BQ=";
      "piet-common-0.5.0" = "sha256-u+3UCSZQDkftHCN7AW0mUROY/yVTgPOcrF+b3Si/2BQ=";
      "piet-coregraphics-0.5.0" = "sha256-u+3UCSZQDkftHCN7AW0mUROY/yVTgPOcrF+b3Si/2BQ=";
      "piet-direct2d-0.5.0" = "sha256-u+3UCSZQDkftHCN7AW0mUROY/yVTgPOcrF+b3Si/2BQ=";
      "piet-web-0.5.0" = "sha256-u+3UCSZQDkftHCN7AW0mUROY/yVTgPOcrF+b3Si/2BQ=";
    };
  };
  # specify the subdirectory of the binary crate to build from the workspace
  buildAndTestSubdir = "psst-gui";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    alsa-lib
    atk
    cairo
    dbus
    gdk-pixbuf
    glib
    gtk3
    pango
  ];

  postInstall = ''
    install -Dm444 psst-gui/assets/logo_512.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    install -Dm444 -t $out/share/applications ${desktopItem}/share/applications/*
  '';

  meta = with lib; {
    description = "Fast and multi-platform Spotify client with native GUI";
    homepage = "https://github.com/jpochyla/psst";
    license = licenses.mit;
    maintainers = with maintainers; [ vbrandl peterhoeg ];
  };
}
