#!/bin/bash
# Merge *.pacnew configuration files with their originals

pacnew="$(sudo find /etc -type f -name "*.pacnew")"

# Check if any .pacnew configurations are found
if [[ -z "$pacnew" ]]; then
  echo " No configurations to update"
fi

for config in $pacnew; do
  # Diff original and new configuration to merge
  vimdiff ${config%\.*} $config
  # Remove .pacnew file?
  while true; do
    read -p " Delete \""$config"\"? (Y/n): " Yn
    case $Yn in
      [Yy]* )
        sudo rm "$config" && echo " Deleted \""$config"\"."
        break
        ;;
      [Nn]* )
        break
        ;;
      * )
        echo " Answer (Y)es or (n)o."
        ;;
    esac
  done
done
