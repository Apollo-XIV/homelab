{ lib, config, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion = {
      enable = true;
      highlight = null;
    };
    defaultKeymap = "viins";
    dirHashes = {
      config = "$HOME/.config/nixos";
    };
    initExtra = ''
      eval "$(zoxide init zsh --cmd cd)"
      eval "$(starship init zsh)"
      source ~/utils.sh
    '';

    shellAliases = {
      tree = "eza --tree --icons --group-directories-first";
      ls = "eza -ahl --icons --group-directories-first";
      cat = "bat";
      zj = "zellij";
      zj-ide = "zellij --layout ~/.config/zellij/layouts/ide.kdl";
      py = "python3";
      tf = "terraform";
      pkl = "pkl-cli";
    };

    syntaxHighlighting = {
      enable = true;
      
    };
  };
}
