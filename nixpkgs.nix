let
  # nixpkgs-unstable @ 2022-06-16
  rev = "29399e5ad1660668b61247c99894fc2fb97b4e74";
  tarball = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = "sha256:0x8brwpxnj3hhz3fy0xrkx5jpm7g0jnm283m8317wal5k7gh6mwf";
  };
in
  import tarball
