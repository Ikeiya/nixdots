{ 
    flake.nixosModules.desktop = { 
        pkgs,
        ... 
    }: {
        # Niri autostartup
        programs.niri.enable = true;
        services.displayManager.sddm = {
            enable = true;
            wayland.enable = true;
        };

        fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            ubuntu-sans
            cm_unicode
            corefonts
            unifont
        ]; 

        services.upower.enable = true;
    };
}