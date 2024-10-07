{ lib, config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [];
    languages = {
      language-servers = {
        superhtml = {
          name = "superhtml";
          command = "${pkgs.superhtml}/bin/superhtml";
        };
        tailwindcss-language-server = {
          name = "tailwindcss-language-server";
          command = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
        };
      };
      language = [
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
        {
          name = "html";
          language-servers = [
            "vscode-html-language-server"
            "tailwindcss-language-server"
          ];
        }
        # {
        #   name = "tailwindcss";
        #   scope = "source.css";
        #   injection-regex = "(postcss|css|html)";
        #   file-types = ["css" "html"];
        #   roots = ["tailwind.config.js" "tailwind.config.cjs"];
        #   language-servers = [
        #     "tailwindcss-language-server"
        #   ];
        # }
      ];
      };
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
