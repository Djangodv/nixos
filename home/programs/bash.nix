{ pkgs, ... }:
{

  programs.bash = {
    enable = true;

    shellAliases = {
      exp-idf = ". $HOME/esp/esp-idf/export.sh";
    };

    initExtra = ''

    gsync () {

      if ! git pull; then
        return 1
      fi

      git add .
      git commit -am "Manual sync"

      read -r -p "Continue pushing all changes? (y/n): " confirm
      if [[ $confirm = "y" ]]; then
        git push
        echo "Succefully pushed all changes. "
      else
        echo "Canceled. "
      fi

    }

    '';

  };

}
