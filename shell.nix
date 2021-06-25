{
  pkgs
}:

pkgs.mkShell rec {
  name = "zetch-env";

  buildInputs = with pkgs; [
    rustup
    lua5_4
  ];

  nativeBuildInputs = with pkgs; [ zig pkgconfig ];
}
