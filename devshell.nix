# Source: https://nixos-and-flakes.thiscute.world/development/intro#creating-a-development-environment-with-pkgs-runcommand

{pkgs, lib, ...}:{

  environment.systemPackages = [
    # Install the wrapper into the system
    (let
      packages = with pkgs; [
        gcc
        cmake
        # Prevents error of: 'CMAKE_MAKE_PROGRAM is not set'
        gnumake
        (python3.withPackages (python-pkgs: with python-pkgs; [
        	# select Python packages here
        	pip
        	pandas
        	jupyter
        	matplotlib
        	numpy
        	seaborn
        	scikit-learn
        ]))
      ];
    in pkgs.runCommand "dev-shell" {
      # Dependencies that should exist in the runtime environment
      buildInputs = packages;
      # Dependencies that should only exist in the build environment
      nativeBuildInputs = [ pkgs.makeWrapper ];
    } ''
      mkdir -p $out/bin/
      ln -s ${pkgs.bash}/bin/bash $out/bin/dev-shell
      wrapProgram $out/bin/dev-shell --prefix PATH : ${pkgs.lib.makeBinPath packages}
    '')
  ];
}
