{lib, config, pkgs, ...}:

{
	programs.wlogout = {
		enable = true;
		layout = [
			{
				label = "shutdown";
				action = "";
				text = "";
				circular = true;
				keybind = "";
				height = 1;
				width = 1;
			}
		];
	};
}
