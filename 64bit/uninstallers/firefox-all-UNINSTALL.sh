#!/bin/bash
# 
# This will uninstall and remove ALL editions of Firefox. Use with care.
# That which is done. Cannot be undone. Reinstalled, of course! But not undone.
#
echo
# Installation
sudo rm -r -f /opt/firefox/
sudo rm -r -f /opt/firefox-beta/
sudo rm -r -f /opt/firefox-developer-edition
sudo rm -r -f /opt/firefox-nightly/
sudo rm -r -f /opt/firefox-esr/
# Menu shortcuts
sudo rm -r -f /usr/share/applications/Firefox.desktop
sudo rm -r -f /usr/share/applications/Firefox-Beta.desktop
sudo rm -r -f /usr/share/applications/Firefox-Developer-Edition.desktop
sudo rm -r -f /usr/share/applications/Firefox-Nightly.desktop
sudo rm -r -f /usr/share/applications/Firefox-ESR.desktop
# Destkop shortcuts
sudo rm -r -f /etc/skel/Desktop/Firefox.desktop
sudo rm -r -f /etc/skel/Desktop/Firefox-Beta.desktop
sudo rm -r -f /etc/skel/Desktop/Firefox-Developer-Edition.desktop
sudo rm -r -f /etc/skel/Desktop/Firefox-Nightly.desktop
sudo rm -r -f /etc/skel/Desktop/Firefox-ESR.desktop
# Current desktop shotcuts
rm -r -f /home/$USER/Desktop/Firefox.desktop
rm -r -f /home/$USER/Desktop/Firefox-Beta.desktop
rm -r -f /home/$USER/Desktop/Firefox-Developer-Edition.desktop
rm -r -f /home/$USER/Desktop/Firefox-Nightly.desktop
rm -r -f /home/$USER/Desktop/Firefox-ESR.desktop
#
# Uncomment if you wish to also delete your configuration files too.
# You should only do so if you have NO other installs of Firefox installed
# Or if your previous install(s) were bad due to bad configuration.
#
# rm -r -f /home/$USER/.mozilla/
# rm -r -f /home/$USER/.cache/mozilla/
echo
echo
echo Thank you for using Mozilla Firefox.
echo Firefox has been deleted and uninstalled. Per your request.
echo Really sorry to see you go.
echo Hope to see you again real soon.
echo
echo
exit 0