
{ lib, config, pkgs, ... }:

{

  options = {
    user.enable = lib.mkEnableOption "enable user module";
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  config = lib.mkIf config.user.enable {
    users.users.root = {
      shell = pkgs.bash;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDxNOQOMCEEN0fDWrthDB5MIEvrAcsjTZ2h7fRY7LhlJ6/j5yqDtX78ZyXRSRcpWQlwCsSAz/pasjweqnmxxyOlMl6IS97ObJqVEHjNH2CXb62I5tkkL+OBpcl6ym4zHL8hJOYF0eXu2p6dI56pkxBRhA04t7bPJHJ5SSYFiBhDAQ9bcILNjqTT6t2Y+JnnGhBS4aPkJPp/Kr59tPBHEN4KLIp75YyALNRHV5CXqz+t5rYUF9d4gBMQgtNWrA4V3OkHpgQt3v+LJjOl9VadicrrGMPsxPU9LkWclklojpCAm6UXqtoQWHYKMpQ2lVF6OYRN7OgRJuPiF71tknn0OdSn366M5uh6hzRfx8CODcUr/HIoUsukDNlW0qvk955OnRqlRaDbF7hsWNzjjHFDpl/Horn6XthIsfP4NQT7qsx+G+7mg/kvsawQp78c2I8NwoF7YL51E7ZbQynUWkBp2TlL2el2JnFh2OFCRa8fFrHJOlio7baeal5ha7ZrzsYaThMUU9nVUm3+dZtmx/vy6Ub8QSmM6bc9hRdASrlvDt0P9SfZfZvIG6/YOpbYjZn7R/RO+wGUrYqBZZF5eINZ4F0nF8k8xqnsfE4YJhdjf3FF2uZhgDug4XKDAG4qkeJJpsR25RJ3nH2nxqdsqFyIO4D9rxG8qFI9+vnr1DncY6t2Dw== acrease@nixos"
      ];
    };
    users.users.acrease = {
      isNormalUser = true;
      description = "Alex Crease";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.bash;
      initialPassword = "changeme";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVoOdKPEt8X4OdIAbKcIUjjTwRqYvfqAf7moZnRbA/7ULA+WAzlrJBIpsOsCM76utvT/jlogz1EUimdJghA3V2o5mVPaQ3D5KUQcB5x0Xr6CoMcpu3Z1QQA/HZEB7+I6S6Ezu7TGz74ZxqQp0LawJaDgGIDNLE4E1yt7PSDMniaM5fjp6NFtqijQx0fUCIGZE2WfRiqweZjiawHYwSpmZBpOyXY3pUrAfeZllOAZf5jOUrLeqDReTNZSDDd+lOwDAUm1CoHqKw1sa/DuUiV86mU8/c6hwgIlzg7yZAbgJkKPiZUZPF4d/h6t0JqD1ljg4yZLw2G2lOMDW1VMVzudDKaq6O1SxjIhebgtZ2Yx3njfC/81QZArL4JhYL6+n0g3s6VY5X+Amdn/6gFRzhDdC5u/fsg+lfLNgi7FeCGJ4bz5HsimE0CrAPN90WZ+auQ8EFwmbuMo3ioekZhrijNymE5b8dB/VIj1wkNlYrnbbUz8blIowfKDZLmZyfF2Bn6YsLIPPQpq5xaJeAg5gdxlhiWMmJ8mly9P0wRn64stcNR0jCEpbKWUKKWKonwiQEuhXtUscEQ/x6hdWIYtRiOcuzlM68r2Iz4Ge/ItL3yMHXz/gwfBerFXTM/vk+GT3bCD1m9d3MuDq8Ilskp34c/GtGbNOpt22TcPNAJmFvJHPX7Q== acrease@mishim"
      ];
      packages = with pkgs; [
				
      #  thunderbird
      ];
    };
    security.sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}
