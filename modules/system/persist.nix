{
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log/"
      "/var/lib/bluetooth/"
      "/var/lib/nixos/"
      "/var/lib/systemd/coredump/"
      "/etc/NetworkManager/system-connections/"
      "/etc/nixos/"
    ];
    files = [
      "/etc/machine-id"
      "/var/db/sudo/lectured/1000"
    ];
  };
}
