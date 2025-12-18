{...}: {
  # k9s configuration (minimal)
  xdg.configFile."k9s/config.yml".text = ''
    k9s:
      liveViewAutoRefresh: true
      ui:
        skin: default
        enableMouse: true
      logger:
        tail: 200
        buffer: 10000
  '';

  # Ensure ~/.kube/configs exists without tracking secrets
  home.file.".kube/configs/.keep".text = "";
}
