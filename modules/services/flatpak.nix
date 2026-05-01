{ config, ... }:
let
  fedoraCABundle = "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem";
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
    "SSL_CERT_FILE=${fedoraCABundle}"
    "CURL_CA_BUNDLE=${fedoraCABundle}"
    "NIX_SSL_CERT_FILE=${fedoraCABundle}"
  ];
}
