{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap { 
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        input = {

          focus-follows-mouse = _:{};

          keyboard = {
            xkb = {
              layout = "us,ua";
            };
            repeat-rate = 40;
            repeat-delay = 250;
          };

          touchpad = {
            natural-scroll = _:{};
            tap = _:{};
          };

          mouse = {
            accel-profile = "flat";
          };
        };

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        layout.gaps = 5;

        binds = {
          "Mod+T".spawn-sh = lib.getExe pkgs.alacritty;
          "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
          "Ctrl+Return".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";

          "Mod+Q".close-window = _:{};
          "Mod+F".maximize-column = _:{};
          "Mod+G".fullscreen-window = _:{};

          "Mod+H".focus-column-left = _:{};
          "Mod+L".focus-column-right = _:{};
          "Mod+K".focus-window-up = _:{};
          "Mod+J".focus-window-down = _:{};

          "Mod+Left".focus-column-left = _:{};
          "Mod+Right".focus-column-right = _:{};
          "Mod+Up".focus-window-up = _:{};
          "Mod+Down".focus-window-down = _:{};

          "Mod+Shift+Left".move-column-left = _:{};
          "Mod+Shift+Right".move-column-right = _:{};
          "Mod+Shift+Up".move-window-up = _:{};
          "Mod+Shift+Down".move-window-down = _:{};

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;
          "Mod+0".focus-workspace = 0;

          "Mod+Alt+1".move-column-to-workspace = 1;
          "Mod+Alt+2".move-column-to-workspace = 2;
          "Mod+Alt+3".move-column-to-workspace = 3;
          "Mod+Alt+4".move-column-to-workspace = 4;
          "Mod+Alt+5".move-column-to-workspace = 5;
          "Mod+Alt+6".move-column-to-workspace = 6;
          "Mod+Alt+7".move-column-to-workspace = 7;
          "Mod+Alt+8".move-column-to-workspace = 8;
          "Mod+Alt+9".move-column-to-workspace = 9;
          "Mod+Alt+0".move-column-to-workspace = 0;

          "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+Shift+E".quit = _:{};
        };
      };
    };
  };
}
