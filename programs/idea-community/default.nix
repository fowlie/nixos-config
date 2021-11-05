{ pkgs, ... }:

{
  home.packages = [
    pkgs.jetbrains.idea-community
    pkgs.jetbrains.jdk
  ];
}
