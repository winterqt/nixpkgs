{ lib
, rustPlatform
, fetchFromGitHub
, cmake
, pkg-config
, expat
, fontconfig
, freetype
}:

rustPlatform.buildRustPackage rec {
  pname = "cicero-tui";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "eyeplum";
    repo = "cicero-tui";
    rev = "v${version}";
    sha256 = "sha256-2raSkIycXCdT/TSlaQviI6Eql7DONgRVsPP2B2YuW8U=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    expat
    fontconfig
    freetype
  ];

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "unic-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-bidi-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-char-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-char-basics-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-char-property-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-char-range-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-common-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-emoji-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-emoji-char-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-idna-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-idna-mapping-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-idna-punycode-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-normal-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-segment-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-age-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-bidi-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-block-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-case-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-category-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-common-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-hangul-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-ident-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-name-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-name_aliases-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-normal-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-segment-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-unihan-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
      "unic-ucd-version-0.9.0" = "sha256-pR7sgde+OM/B/8gfI0dN6nIPapdZFAXiWwQeaw2MDDI=";
    };
  };

  meta = with lib; {
    description = "Unicode tool with a terminal user interface";
    homepage = "https://github.com/eyeplum/cicero-tui";
    license = with licenses; [ gpl3Plus ];
    maintainers = with maintainers; [ shamilton ];
    platforms = platforms.linux;
  };
}
