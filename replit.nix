{pkgs}: {
  deps = [
    pkgs.rustc
    pkgs.libiconv
    pkgs.cargo
    pkgs.run
    pkgs.postgresql
    pkgs.openssl
  ];
}
