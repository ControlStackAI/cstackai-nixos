{config, ...}: {
  # Secrets management (sops-nix): optional, guarded if file exists
  sops =
    if builtins.pathExists ../../secrets/home.yaml
    then {
      defaultSopsFile = ../../secrets/home.yaml;
      # Use an Age key file in your home directory
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    }
    else {};
}
