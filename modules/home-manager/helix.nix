{ lib, config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [];
    languages.language = [
      {
        name = "markdown";
        soft-wrap = {
          enable = true;
          max-wrap = 20;
          max-indent-retain = 0;
          wrap-indicator = "";
          wrap-at-text-width = true;
        };
        text-width = 80;
      }
      {
        name = "hcl";
        file-types = ["hcl" "tf" "tftpl"];
      }
    ];
    settings = {
      # theme = "kanagawa";
      editor = {
        rulers = [80 120];
        line-number = "relative";
        bufferline = "multiple";
        cursorline = true;
        cursorcolumn = true;
        file-picker.hidden = false;
        indent-guides = {
          render = true;
          character = "╎";
          skip-levels = 1;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        lsp = {
          auto-signature-help = false;
          display-messages = false;
        };
        statusline = {
          left = ["mode" "spinner" "version-control" "file-name"];
        };
      };
      keys.normal = {
        "A-," = "goto_previous_buffer";
        "A-." = "goto_next_buffer";
        "A-w" = ":buffer-close";
      };
      keys.insert = {
        j = { k = "normal_mode"; };
      };
    };
  };

}
