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
				keybind = "";
			}
			{
				label = "logout";
				action = "sleep 1; hyprctl dispatch exit";
				text = "logout";
				circular = true;
				keybind = "";
			}
			{
				label = "shutdown";
				action = "systemctl poweroff";
				text = "shutdown";
				circular = true;
				keybind = "";
			}
			{
				label = "reboot";
				action = "systemctl reboot";
				text = "reboot";
				circular = true;
				keybind = "";
			}
		];
    style = ''
      * {
      	background-image: none;
      }
      window {
      	background-color: rgba(28, 51, 33, 0.5);
      }
      button {
        color: #0f2137;
      	font-size: 16px;
      	background-color: #e7e7ec;
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
      	background-color: #b9b1e2;
      	outline-style: none;
      }

			/*
      #lock {
          background-image: image(url(""), url("/usr/local/share/wlogout/icons/lock.png"));
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
          background-image: image(url(""), url("/usr/local/share/wlogout/icons/reboot.png"));
      }
			*/
    '';
	};
}
