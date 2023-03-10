let
  # nixos-22.11 @ 2023-02-27
  rev = "7076110064c09f0b3942f609f2134c1358ef2e50";
  tarball = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = "sha256:0j7idx8vyb0spwxqb7rr8pk15wi7yfyf5hp608wkhaz7wjw8k9nf";
  };
in
  import tarball
