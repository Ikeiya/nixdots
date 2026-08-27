{ 
    flake.nixosModules.tlp = { 
        ... 
    }: {
        services.power-profiles-daemon.enable = false;

        services.tlp = {
            enable = true;

            settings = {
                # CPU governor
                CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
                CPU_SCALING_GOVERNOR_ON_AC = "performance";

                # Energy perf policy
                CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
                CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

                # Charge threshold
                START_CHARGE_THRESH_BAT0 = "75";
                STOP_CHARGE_THRESH_BAT0 = "80";

                # Startup devices
                DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
            };
        };
    };
}