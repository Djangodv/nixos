# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

let
	nixvirt = inputs.nixvirt;
  secondaryDrive = "/data";
in
{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix # Include the results of the hardware scan.
      ./pkgs.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-demo"; # Define your hostname.

  # Temporarily disable firewall for ease of use (dangerous)
  # networking.firewall.enable = false;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # SDDM Display Manager
  services.displayManager.sddm.enable = true;

  # Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Exclude certain default applications from being installed
  environment.plasma6.excludePackages = with pkgs; [ 
    kdePackages.kate
    kdePackages.elisa
    kdePackages.konsole
    kdePackages.kwalletmanager
    kdePackages.plasma-workspace-wallpapers
   ]; 

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu-mono
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.variables.EDITOR = "vim";

  # Custom system-wide .vimrc configuration
	environment.systemPackages = with pkgs; [
    ((vim.override{ }).customize {
      name = "vim";
      vimrcConfig.customRC = ''
				" Custom vimrc
				set mouse=a
				set number
				set tabstop=2 shiftwidth=2
				set ignorecase
				" Turn on syntax highlighting by default
				syntax on
      '';
    })
	];

  nixpkgs.config.allowUnfree = true;

  # Enable the OpenSSH daemon.
  # services.openssh = {
  #   enable = true;
  #   # settings = {
  #     # PasswordAuthentication = true;
  #   # };
  #   hostKeys = [
  #     {
  #       bits = 4096;
  #       path = "/home/user/.ssh/id_ed25519";
  #       type = "ed25519";
  #       comment = "user@nixos-demo";
  #     }
  #     {
  #       bits = 4096;
  #       path = "/home/user/.ssh/id_ed25519_school";
  #       type = "ed25519";
  #       comment = "user@nixos-demo";
  #     }
  #   ];
  # };

  # systemd.services.keys = {
  #   enable = true;
  #   description = "Change file permissions of keys in /home/user/.ssh";
  #   # Specifies the service should start when non-gfx multi-user shell is ready
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "home-manager-user.service" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = ''/bin/sh -c "chown user:users /home/user/.ssh/id_ed25519*"'';
  #     # User = "user";
  #     # Group = "users";
  #   };
  # };

  # Turn on periodic optimisation of the nix store
  nix.optimise.automatic = true; # Runs at 03:45 by default, but when system was off reschedules it at next startup
  # nix.optimise.dates = [ "03:45" ]; # Optional; allows customizing optimisation schedule

  # Automatic garbage collection using `nix-store --gc`
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Enable virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

	# Rules for the creation, deletion and cleaning of files and directories, see: https://mynixos.com/nixpkgs/option/systemd.tmpfiles.rules
	systemd.tmpfiles.rules = [
    # Creates a directory with specified mode and root ownership (needed for libvirt to work)
		"d ${secondaryDrive}/virtual 0711 root root - -"
		"d ${secondaryDrive}/docker 710 user user - -"
	];

	# Use NixVirt to setup libvirt domains, networks and pools declaratively
	# After setup use: 'sudo virsh pool-autostart ssd' to autostart pool
	virtualisation.libvirt.connections."qemu:///session".pools =
	 [
	   {
	     definition = nixvirt.lib.pool.writeXML (
	       {
	         type = "dir";
	         name = "ssd";
	         target = {
	           path = "${secondaryDrive}/virtual";
	         };
	       }
	     );
	     active = true;
	     restart = true;
	   }
	 ];

	# Enable Docker
  # Source: https://wiki.nixos.org/wiki/Docker
  # Fix: https://discourse.nixos.org/t/rootless-docker-broken-unit-docker-service-not-found/65112/12
	virtualisation.docker = {
    enable = false;
    
    # Periodically run `docker system prune -f` to remove dangling Docker resources
    autoPrune = {
      enable = true;
      dates = "weekly";
    };

    rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings = {
        data-root = "${secondaryDrive}/docker";
        # features.cdi = true; # Enable Nvidia CDI (GPU)
      };
    };

  };

	# Needed for Docker to communicate with the gpu
	# hardware.nvidia-container-toolkit.enable = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

	# Some games require 32-bit OpenGl support
	# Source: https://thelinuxcode.com/how-to-instal-steam-on-nixos/
	# hardware.opengl.driSupport32Bit = true;

	# Load nvidia driver for Xorg and Wayland
  # services.xserver.videoDrivers = ["nvidia"]; # Uncomment this line to enable Nvdia drivers

	hardware.nvidia = {

		# Modesetting is required
		modesetting.enable = true;

		# Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

		# Enable the Nvidia settings menu, accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Default

	};

	hardware.nvidia.prime = {

		# Sadly sync mode is the only option for a hybrid graphics setup (e.g. laptop) with older hardware
		sync.enable = true;

		# Make sure to use the correct Bus ID values for your system!
		intelBusId = "PCI:0:2:0";
		nvidiaBusId = "PCI:1:0:0";
	};

	# Source: https://blog.kaorubb.org/en/posts/nixos-fix-could-not-start-dynamically-linked-executable/
	# Fix 'NixOS cannot run dynamically linked executables intended for generic linux environments out of the box'
	programs.nix-ld.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
