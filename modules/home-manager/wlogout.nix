{lib, config, pkgs, ...}:

{
	programs.wlogout = {
		enable = true;
		layout = [
			{
				label = "lock";
				action = "sleep 1; hyprlock";
				text = "lock";
				circular = true;
				keybind = "";
				height = 0.5;
				width = 0.5;
			}
			{
				label = "logout";
				action = "sleep 1; hyprctl dispatch exit";
				text = "logout";
				circular = true;
				keybind = "";
				height = 0.5;
				width = 0.5;
			}
			{
				label = "shutdown";
				action = "systemctl poweroff";
				text = "shutdown";
				circular = true;
				keybind = "";
				height = 0.5;
				width = 0.5;
			}
		];
	};
}
