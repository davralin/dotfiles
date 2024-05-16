{ config, pkgs, ... }:

{
  # Enable invidious
  services.invidious = {
	enable = true;
	# address = "127.0.0.1"; # Unstable
	};
}
