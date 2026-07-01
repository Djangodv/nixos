{
  disko.devices = {
    disk = {
      main = {
        device = "";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            EFI = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = "8G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true; # resume from hiberation from this device
              }; 
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };

      # TODO: Test below setup for paritioning a secondary drive
      # ssd = {
      #   device = "";
      #   type = "disk";
      #   content = {
      #     type = "gpt";
      #     partitions = {
      #       root = {
      #         size = "100%";
      #         content = {
      #           type = "filesystem";
      #           format = "ext4";
      #           mountpoint = "/data";
      #         };
      #       };
      #     };
      #   };
      # };
    };
  };
}
