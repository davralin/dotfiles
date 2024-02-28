{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mikr = {
    isNormalUser = true;
    description = "Mikkel";
    extraGroups = [ "networkmanager" "wheel" ];
    initialHashedPassword = "$6$98sQ0D0M5Gl5Rxoi$VA9qFqijQa1myZOK/85JchF6Ii1kwAkiZQVKEUzS27/tFloaa11/2ahwarnvz7b3HvMuCCTpeXMwvaEeQr8T71";
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDK16+6/jzCvp3Sthg0S0JY2syS3ypa8kxkLr34mJghisvIr4o3G3o0PAaB9rZHd/M2cmZYP7/bkXt/QpWWjaOlztQvYd3oZ9sAl5Omt0kKcmzdsiz5om+0sBfpHVBgkC+nBFgF3+/e2hMh8Z7xqPfbFhpZjBDozh2HflN09xwt5K1fREflxLZfQl9VYLbwRhRtlpmPOXmMWO+6jF90tggvLs926zIV1oe+cQbxrdhPyq09fCAvZKPOfurrJBjB+EZ2IJIwhL/GpkANOBp3TmoES/FVkvzkYrdHq9DVqq4rm1L5FK85ssQK6Fk0VVh7fWknIoMzLRnPRFoMBcb+7dU2TrwY0IIaepulrWtGSSmSjzQXkEP9KnCoFtHxSj5qSgYX1PjSiXoVAEULhQdCQzp2DEwDbiwDKbaZ1VBCwH4TDII9zWYJ355CguD03hWrdrpSXbWE3JFHZtT/ZYK2J23yZEiWY6wMW5YvGSY6kRZzpg6bnCmxi1PlRuLmlWDR/dUTSp+WMmAv/wnbHyLJD5WGJnmSXlI+xYsdbl+VjUpOylBEOR+wWKNww9UTS6U+aYZJ8bh5tDSvgxrg6qJoij/UlG3yQUX3hRi/iWctETJ3PSTRyFY5QNZjhnaglR+NKDn0vvZ6GF759wQ9gkOoYEuXmHFHKaymvowE+qIGXhgSnw==" ];
  };
  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "mikr";
}
