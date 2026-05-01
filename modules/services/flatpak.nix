{ config, pkgs, ... }:
let
  caBundle = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
in
{
  services.flatpak = {
    enable = true;
    packages = [
      "app.zen_browser.zen"
      "com.discordapp.Discord"
      "com.bitwarden.desktop"
      "com.getpostman.Postman"
      "md.obsidian.Obsidian"
      "org.videolan.VLC"
      "com.mongodb.Compass"
    ];
  };

  systemd.user.services."flatpak-managed-install".Service.Environment = [
    "SSL_CERT_FILE=${caBundle}"
    "CURL_CA_BUNDLE=${caBundle}"
    "NIX_SSL_CERT_FILE=${caBundle}"
  ];
}
