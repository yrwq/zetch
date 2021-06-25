with import <nixos-unstable> { };

stdenv.mkDerivation rec {
  name = "zetch-env";

  buildInputs = [
    lua5_4
  ];

  nativeBuildInputs = [
    zig
  ];
}
