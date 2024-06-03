
{ lib, config, pkgs, ... }:

{

  options = {
    user.enable = lib.mkEnableOption "enable user module";
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  config = lib.mkIf config.user.enable {
    users.users.acrease = {
      isNormalUser = true;
      description = "Alex Crease";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
      initialPassword = "changeme"
      openssh.authorizedkeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCMwxyfSaaKBkv4nUyxPqaCPRab1881itvX/0AxiHYMyqf36iCgjqbfjcFVe3FBxn4J3yH38yNJu2DuN0eMClKkejbc9wtYudRfYcUDwN8QATEALTsSDaxvR2q6QhnTXqqY826BALvjKVaMKZfKfuWpg/FoEdd1jYmzOxT6Q1mtXkNKgoQd9NGXLB87vqh3z2YoSvzhbNrgI1/hXZz1dq6iEUImh73Z6EV2rfH6pZCSuTlFB2Qrdb6ecn9g9LcyXzpPSLsj7Xf1gn75XWjlE1MqMbpN/FuzzUvl0EQP/JmgWJvwWQeBx6/Dco36VS7QYHsFmJH/5MfvL7hsiQdohmv1KmOcfVu08edKHomsV79XBLPGIthXSA8jly+2CfS/T8OpBqXFI4QbGJusGyMdsliVInZdnqzSGB3DgVZH9WbR1VRjwiaCi/0QUiQuVb8GbvaqK9JAK4fR5djuqGQG8go3r96jyyh2t77wWLqLcl1uW8sw22p2CI/XBbtxsS9ihdkdh7Xjl23NssgMihCy7QD2Kgl9XzLNViYu3xBdRJsV9rHet9UGx/kxjzzA2SS3aBXS/lG4KBNYWcEqDeM6otTAbY+nBfkXuQC567e2Jh66jf44/vthkL/bxpOncurbGH9Ek6JfhwUnx39oFZWOrpmJPJIuMqoFL0WNM4EPL8+HeQ== acrease@nixos"
      ]
      packages = with pkgs; [
				
      #  thunderbird
      ];
    };
  };
}