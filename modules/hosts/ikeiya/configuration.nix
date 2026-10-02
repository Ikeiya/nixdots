{ self, inputs, ... }: {

  flake.nixosModules.myMachineConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.niri
      self.nixosModules.tlp
      self.nixosModules.desktop
    ];

# Allow flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

# Use latest kernal
    boot.kernelPackages = pkgs.linuxPackages_latest;

# Enable networking
    networking.hostName = "ikeiya";
    networking.networkmanager.enable = true;

# Set your time zone
    time.timeZone = "Europe/London";

# Select internationalisation properties
    i18n.defaultLocale = "en_GB.UTF-8";

# Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

# Configure console keymap
    console.keyMap = "us";

# Define a user account
    users.users."ikeiya" = {
      isNormalUser = true;
      description = "ikeiya";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };

# Allow unfree packages
    nixpkgs.config.allowUnfree = true;

# List packages install ed in system profile
    environment.systemPackages = with pkgs; [

# Terminal
      alacritty
      kdePackages.dolphin

# Text editor
      neovim
      vscodium

# Libreoffice
      libreoffice-qt
      hunspell
      hunspellDicts.uk_UA
      hunspellDicts.th_TH

# Browsers
      wget
      librewolf
      ungoogled-chromium

# Util
      git
      p7zip
      peazip
      keepassxc

# Social
      vesktop

# Entertainment
      steam
    ];

    programs.steam.enable = true;

    system.stateVersion = "26.05";

  };
}
