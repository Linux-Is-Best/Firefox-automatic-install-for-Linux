#!/bin/sh
#
# Uninstalling Firefox notice
echo
 while true; do
    read -p "Are you sure you wish to remove and delete 
Mozilla Firefox Beta release from your computer?" yn
    case $yn in
        [Yy]* ) clear; echo "Uninstalling Mozilla Firefox Beta release"; echo; echo;
# Small delay to give user time to read the above notice.
sleep 3;
# Installation
sudo rm -r -f  /opt/firefox-beta/ ;
# Menu shortcuts
sudo rm -r -f /usr/share/applications/Firefox-Beta.desktop ;
# Desktop shortcuts
sudo rm -r -f /etc/skel/Desktop/Firefox-Beta.desktop ;
# Current shortcuts
sudo rm -r -f /home/*/Desktop/Firefox-Beta.desktop ;
# Uncomment if you wish to delete file cache.
# sudo rm -r -f /home/*/.cache/mozilla/firefox/*.default-beta*/ ;
# Uncomment if you wish to delete configuration and profile files.
# sudo rm -r -f /home/*/.mozilla/firefox/*.default-beta*/ ;
echo; echo; echo "Thank you for using Mozilla Firefox.";
echo "Firefox has been deleted and uninstalled. Per your request.";
echo "Really sorry to see you go. Hope to see you again real soon."; echo; echo; break ;;
        [Nn]* ) echo; echo "You said, NO. Nothing has changed at this time."; echo; echo; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
exit 0
