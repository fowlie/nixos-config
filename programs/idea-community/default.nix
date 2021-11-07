# doesn't work, maybe try packageOverride?
# see https://matklad.github.io/2017/03/25/nixos-notes.html
{ pkgs, ... }:

{
  home.packages = [
    pkgs.jetbrains.idea-community
    pkgs.jetbrains.jdk
  ];
}
