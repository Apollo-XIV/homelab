{ lib, config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      copy_command = "wl-copy";
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
      # theme = "catppuccin-macchiato";
    };
  };
  home.file = {
    # ".config/zellij/layouts/default.kdl".source = "modules/zellij-layouts/default.kdl";
    ".config/zellij/layouts/default.kdl".text = ''
      layout {
      	pane size=1 borderless=true {
      	    plugin location="https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm" {
      	        format_left   "{mode} #[fg=#89B4FA,bold]{session}"
      	        format_center "{tabs}"
      	        format_right  "{command_git_branch} {datetime}"
      	        format_space  ""

      	        border_enabled  "false"
      	        border_char     "─"
      	        border_format   "#[fg=#6C7086]{char}"
      	        border_position "top"

      	        hide_frame_for_single_pane "true"

      	        mode_normal  "#[bg=blue] "
      	        mode_tmux    "#[bg=#ffc387] "

      	        tab_normal   "#[fg=#6C7086] {name} "
      	        tab_active   "#[fg=#9399B2,bold,italic] {name} "

      	        command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
      	        command_git_branch_format      "#[fg=blue] {stdout} "
      	        command_git_branch_interval    "10"
      	        command_git_branch_rendermode  "static"

      	        datetime        "#[fg=#6C7086,bold] {format} "
      	        datetime_format "%A, %d %b %Y %H:%M"
      	        datetime_timezone "Europe/Berlin"
      	    }
      	}
      	pane {
      	}
      }
    '';
    ".config/zellij/layouts/ide.kdl".text = ''
      layout {
      	pane size=1 borderless=true {
      	    plugin location="https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm" {
      	        format_left   "{mode} #[fg=#89B4FA,bold]{session}"
      	        format_center "{tabs}"
      	        format_right  "{command_git_branch} {datetime}"
      	        format_space  ""

      	        border_enabled  "false"
      	        border_char     "─"
      	        border_format   "#[fg=#6C7086]{char}"
      	        border_position "top"

      	        hide_frame_for_single_pane "true"

      	        mode_normal  "#[bg=blue] "
      	        mode_tmux    "#[bg=#ffc387] "

      	        tab_normal   "#[fg=#6C7086] {name} "
      	        tab_active   "#[fg=#9399B2,bold,italic] {name} "

      	        command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
      	        command_git_branch_format      "#[fg=blue] {stdout} "
      	        command_git_branch_interval    "10"
      	        command_git_branch_rendermode  "static"

      	        datetime        "#[fg=#6C7086,bold] {format} "
      	        datetime_format "%A, %d %b %Y %H:%M"
      	        datetime_timezone "Europe/Berlin"
      	    }
      	}
      	pane split_direction="vertical" {
      		pane stacked=true {
      			pane
      			pane
      			pane
      		}		
      		pane borderless=true size="40%"
      	}
      }
    '';
  };
}
