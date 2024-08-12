{lib, config, pkgs, ...}:

{
	programs.wlogout = {
		enable = true;
		layout = [
			{
				label = "lock";
				action = "hyprlock";
				text = "lock";
				circular = true;
				keybind = "l";
			}
			{
				label = "logout";
				action = "sleep 1; hyprctl dispatch exit";
				text = "logout";
				circular = true;
				keybind = "L";
			}
			{
				label = "shutdown";
				action = "systemctl poweroff";
				text = "shutdown";
				circular = true;
				keybind = "s";
			}
			{
				label = "reboot";
				action = "systemctl reboot";
				text = "reboot";
				circular = true;
				keybind = "r";
			}
		];
    style = ''
      * {
      	background-image: none;
      }
      window {
      	background-color: rgba(18, 31, 23, 0.5);
      }
      button {
        color: #e5e5e5;
      	font-size: 16px;
      	background-color: #17171c;
      	border-style: none;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 35%;
      	border-radius:30px;
      	margin: 182px 5px;
      	text-shadow: 0px 0px;
      	box-shadow: 0px 0px;
      }

      button:focus, button:active, button:hover {
      	background-color: #194112;
      	outline-style: none;
      }

			/*
      #lock {
          background-image: image(url("/home/acrease/Documents/homelab/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
      }

      #logout {
          background-image: image(url(""), url("/usr/local/share/wlogout/icons/logout.png"));
      }

      #suspend {
          background-image: image(url(""), url("/usr/local/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
          background-image: image(url(""), url("/usr/local/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
          background-image: image(url(""), url("/usr/local/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
          background-image: image(url("/home/acrease/Documents/homelab/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
      }
			*/
    '';
	};
}
