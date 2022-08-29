#!/bin/sh
#
# Installs Mozilla Firefox (beta release). To be used with Setup.sh
#
# Make error.sh exactable so it can execut if needed.
chmod +x ./32bit/error.sh;
# Download notice.
printf -- '\n\n%s\n\n\n\n' " Please wait. I am downloading the latest version of Mozilla Firefox Beta.";
#4-second wait before beginning download. Gives user time to read the above sentence and understand what is happening.
sleep 4;
# Download using wget with curl failback.
wget -L -O "FirefoxBeta.tar.bz2" "https://download.mozilla.org/?product=firefox-beta-latest-ssl&os=linux" >/dev/null || curl -L -o "FirefoxBeta.tar.bz2" "https://download.mozilla.org/?product=firefox-beta-latest-ssl&os=linux" || /.error.sh ;
# Begin install notice.
printf -- '\n\n\n%s\n\n' " Installing Mozilla Firefox Beta.";
# Checks if distro has default opt path and if not found adds opt with default permissions.
sudo mkdir -p -m 755 /opt ;
# Path where to be installed.
sudo mkdir /opt/firefox-beta-32bit ;
# Extracts to install path.
sudo tar xjf FirefoxBeta32.tar.bz2 -C /opt/firefox-beta-32bit/ ;
# Required permissions needed for Mozilla Firefox automatic update feature to work.
sudo chmod -R 757 /opt/firefox-beta-32bit/firefox/ ;
# Start create icon script
chmod +x ./32bit/icon-beta32.sh ; bash ./32bit/icon-beta32.sh ;
# Give time for icon script to complete
sleep 2;
# Makes icon executable allowing it to run Firefox (which is also executable).
chmod +x Firefox-Beta-32bit.desktop ;
# Adds icon to application menu (xfce, gnome, cinnamon, mate, deepin, etc...).
sudo cp Firefox-Beta-32bit.desktop /usr/share/applications ;
# Copies desktop icon to all user desktops and grants them ownership (it is their desktop after all).
for destdir in /home/*/Desktop/; do
    cp Firefox-Beta-32bit.desktop "$destdir" &&
    chown --reference="$destdir" "$destdir/Firefox-Beta-32bit.desktop"
done
printf "\n";
# Adds a desktop icon to all FUTURE new login users (assuming you make any).
sudo mkdir -p /etc/skel/Desktop ; sudo cp Firefox-Beta-32bit.desktop /etc/skel/Desktop ;
# Removes the temporary files no longer needed.
rm FirefoxBeta32.tar.bz2 ; rm Firefox-Beta-32bit.desktop ;
# Exit notice.
printf -- '%s\n' "" "" "" " Congratulations!" \
  " Mozilla Firefox Beta is now installed onto your computer." \
  " Mozilla Firefox Beta will update itself." \
  " Happy browsing." "" ""
# exit
exit 0
