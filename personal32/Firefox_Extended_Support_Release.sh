#!/bin/sh
#
# Firefox Automatic Install for Linux - Firefox Extended Support Release (ESR)) - personal - 32-bit

## SUSE Patch -- Will safely skip if not using a SUSE based distribution and continue with normal install of Firefox. ##

# SUSE Linux stands out as an exceptional distribution with one notable absence: it lacks a crucial, free, and fundamental library that
# is typically present in most mainstream distributions. As a consequence, extracting a standard TAR.BZ2 file becomes impossible 
# without this essential library. For instance, the straightforward command 'sudo tar xjf file_name.tar.bz2 -C /opt/path_name/' would
# fail to execute. It might be worthwhile to encourage SUSE to reconsider their stance and include this library to alleviate such inconveniences.

# Function to get the value of a specific key from /etc/os-release
get_os_release_value() {
  key="$1"
  awk -F= -v k="$key" '$1 == k {gsub("\"", "", $2); print $2}' /etc/os-release
}

# Check if the OS is SUSE or openSUSE
if [ -f "/etc/os-release" ]; then
  ID="$(get_os_release_value ID)"
  if [ "$ID" = "suse" ] || [ "$ID" = "opensuse" ]; then
    # Check if bzip2 is installed
    if ! command -v bzip2 >/dev/null 2>&1; then
printf "Hello there!\n\n"
printf "We want to ensure you have the best experience with SUSE Linux.\n"
printf "Typically, all mainstream Linux distributions come with a free library that makes working with TAR.BZ2 archives a breeze.\n\n"
printf "However, in SUSE Linux, this library is not included by default.\n"
printf "But don't worry, we've got you covered!\n\n"
printf "To work with standard TAR.BZ2 archives in SUSE, simply install the 'bzip2' package by following these simple steps:\n"
printf "1. Contact your system administrator (if you're not one yourself).\n"
printf "2. Ask them to install the 'bzip2' package on your system.\n"
printf "Once that's done, you'll be able to handle TAR.BZ2 files without any hassle.\n\n"
printf "If you find this library essential and believe it would benefit other SUSE users as well, consider letting SUSE know!\n"
printf "You can reach out to their support team or visit their website to share your feedback.\n"
printf "User input is valuable, and feedback often drives positive changes in future releases.\n\n"
printf "We're here to help you make the most out of your SUSE experience!\n"
      exit 1
    fi
  fi
fi

## End SUSE Patch -- We now return to our regular scheduled programming. ##

# Function to display the error message
display_error_message() {
  printf -- '\n%s\n' "" "" "" "Oops, something went wrong!" \
    "I apologize, but I couldn't download Firefox from Mozilla." \
    "There are a few possible reasons for this:" \
    "  - It's possible that either 'curl' or 'wget' is not available on your computer." \
    "  - Your internet connection might be experiencing issues." \
    "Please take the following steps to troubleshoot the problem:" \
    "  - If 'curl' or 'wget' is not installed, please install either of them (either will work)." \
    "  - Check your internet connection and ensure it's working properly." \
    "If you need further assistance, feel free to contact your system administrator." \
    "" " " \
    "I'm now exiting the install process. Nothing has changed on your computer." "" ""

  # Error exit.
  exit 1
}

# Download notice.
printf -- '\n%s\n' "
Please wait. I am downloading the latest version of Mozilla Firefox Extended Support Release.
"

# 4-second wait before beginning download. Gives the user time to read the above sentence and understand what is happening.
sleep 4

# Define the file to download
url="https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=linux"
file="FirefoxESR32.tar.bz2"

# Function to download with wget or curl, depending on availability
download_with_wget_or_curl() {
  if command -v wget >/dev/null 2>&1; then
    wget -L --show-progress -O "$file" "$url" || return 1
  elif command -v curl >/dev/null 2>&1; then
    curl -# -L -o "$file" "$url" || return 1
  else
    return 1
  fi
}

# Attempt to download with wget or curl
if ! download_with_wget_or_curl; then
  display_error_message
fi

# Begin install notice.
printf -- '\n\n\n%s\n\n' "
Installing Mozilla Firefox Extended Support Release.
"

# Create /Mozilla directory in /home/$USER if it doesn't exist
mkdir -p "$HOME"/Mozilla ;

# Set permissions for
chmod 755 "$HOME"/Mozilla ;

# Path where to be installed.
mkdir "$HOME"/Mozilla/firefox_esr32 ;

# Extracts to install path.
tar xjf "$file" -C "$HOME"/Mozilla/firefox_esr32/ ;

# Required permissions needed for Mozilla Firefox automatic update feature to work.
chmod -R 757 "$HOME"/Mozilla/firefox_esr32/firefox/ ;

# Create icon script using echo command - Both the name and file name should be different from the 64-bit editions
printf "[Desktop Entry]
Exec=$HOME/Mozilla/firefox_esr32/firefox/firefox %%u --class FirefoxESR32
Icon=$HOME/Mozilla/firefox_esr32/firefox/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
StartupWMClass=FirefoxESR32
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;
# Both the name and file name should be different from the 64-bit
Name=Firefox ESR 32-bit
# Both the name and file name should be different from the 64-bit
GenericName=Web Browser
GenericName[ar]=متصفح وِب
GenericName[ast]=Restolador Web
GenericName[bn]=ওয়েব ব্রাউজার
GenericName[ca]=Navegador web
GenericName[cs]=Webový prohlížeč
GenericName[da]=Webbrowser
GenericName[de]=Webbrowser
GenericName[el]=Περιηγητής διαδικτύου
GenericName[es]=Navegador web
GenericName[et]=Veebibrauser
GenericName[fa]=مرورگر اینترنتی
GenericName[fi]=WWW-selain
GenericName[fr]=Navigateur Web
GenericName[gl]=Navegador Web
GenericName[he]=דפדפן אינטרנט
GenericName[hr]=Web preglednik
GenericName[hu]=Webböngésző
GenericName[it]=Browser Web
GenericName[ja]=ウェブ・ブラウザ
GenericName[ko]=웹 브라우저
GenericName[ku]=Geroka torê
GenericName[lt]=Interneto naršyklė
GenericName[nb]=Nettleser
GenericName[nl]=Webbrowser
GenericName[nn]=Nettlesar
GenericName[no]=Nettleser
GenericName[pl]=Przeglądarka WWW
GenericName[pt]=Navegador Web
GenericName[pt_BR]=Navegador Web
GenericName[ro]=Navigator Internet
GenericName[ru]=Веб-браузер
GenericName[sk]=Internetový prehliadač
GenericName[sl]=Spletni brskalnik
GenericName[sv]=Webbläsare
GenericName[tr]=Web Tarayıcı
GenericName[ug]=توركۆرگۈ
GenericName[uk]=Веб-браузер
GenericName[vi]=Trình duyệt Web
GenericName[zh_CN]=网络浏览器
GenericName[zh_TW]=網路瀏覽器
Comment=Browse the Web
Comment[ar]=تصفح الوِب
Comment[ast]=Restola pela Rede
Comment[bn]=ইন্টারনেট ব্রাউজ করুন
Comment[ca]=Navegueu per el web
Comment[cs]=Prohlížení stránek World Wide Webu
Comment[da]=Surf på internettet
Comment[de]=Im Internet surfen
Comment[el]=Μπορείτε να περιηγηθείτε στο διαδίκτυο (Web)
Comment[es]=Navegue por la web
Comment[et]=Lehitse veebi
Comment[fa]=صفحات شبکه جهانی اینترنت را مرور نمایید
Comment[fi]=Selaa Internetin WWW-sivuja
Comment[fr]=Naviguer sur le Web
Comment[gl]=Navegar pola rede
Comment[he]=גלישה ברחבי האינטרנט
Comment[hr]=Pretražite web
Comment[hu]=A világháló böngészése
Comment[it]=Esplora il web
Comment[ja]=ウェブを閲覧します
Comment[ko]=웹을 돌아 다닙니다
Comment[ku]=Li torê bigere
Comment[lt]=Naršykite internete
Comment[nb]=Surf på nettet
Comment[nl]=Verken het internet
Comment[nn]=Surf på nettet
Comment[no]=Surf på nettet
Comment[pl]=Przeglądanie stron WWW
Comment[pt]=Navegue na Internet
Comment[pt_BR]=Navegue na Internet
Comment[ro]=Navigați pe Internet
Comment[ru]=Доступ в Интернет
Comment[sk]=Prehliadanie internetu
Comment[sl]=Brskajte po spletu
Comment[sv]=Surfa på webben
Comment[tr]=İnternet'te Gezinin
Comment[ug]=دۇنيادىكى توربەتلەرنى كۆرگىلى بولىدۇ
Comment[uk]=Перегляд сторінок Інтернету
Comment[vi]=Để duyệt các trang web
Comment[zh_CN]=浏览互联网
Comment[zh_TW]=瀏覽網際網路

[Desktop Action new-window]
Exec=$HOME/Mozilla/firefox_esr32/firefox/firefox --new-window %%u --class FirefoxESR32
Name=New Window
Name[ach]=Dirica manyen
Name[af]=Nuwe venster
Name[an]=Nueva finestra
Name[ar]=نافذة جديدة
Name[as]=নতুন উইন্ডো
Name[ast]=Ventana nueva
Name[az]=Yeni Pəncərə
Name[be]=Новае акно
Name[bg]=Нов прозорец
Name[bn_BD]=নতুন উইন্ডো (N)
Name[bn_IN]=নতুন উইন্ডো
Name[br]=Prenestr nevez
Name[brx]=गोदान उइन्ड'(N)
Name[bs]=Novi prozor
Name[ca]=Finestra nova
Name[cak]=K'ak'a' tzuwäch
Name[cs]=Nové okno
Name[cy]=Ffenestr Newydd
Name[da]=Nyt vindue
Name[de]=Neues Fenster
Name[dsb]=Nowe wokno
Name[el]=Νέο παράθυρο
Name[en_GB]=New Window
Name[en_US]=New Window
Name[en_ZA]=New Window
Name[eo]=Nova fenestro
Name[es_AR]=Nueva ventana
Name[es_CL]=Nueva ventana
Name[es_ES]=Nueva ventana
Name[es_MX]=Nueva ventana
Name[et]=Uus aken
Name[eu]=Leiho berria
Name[fa]=پنجره جدید
Name[ff]=Henorde Hesere
Name[fi]=Uusi ikkuna
Name[fr]=Nouvelle fenêtre
Name[fy_NL]=Nij finster
Name[ga_IE]=Fuinneog Nua
Name[gd]=Uinneag ùr
Name[gl]=Nova xanela
Name[gn]=Ovetã pyahu
Name[gu_IN]=નવી વિન્ડો
Name[he]=חלון חדש
Name[hi_IN]=नया विंडो
Name[hr]=Novi prozor
Name[hsb]=Nowe wokno
Name[hu]=Új ablak
Name[hy_AM]=Նոր Պատուհան
Name[id]=Jendela Baru
Name[is]=Nýr gluggi
Name[it]=Nuova finestra
Name[ja]=新しいウィンドウ
Name[ja_JP-mac]=新規ウインドウ
Name[ka]=ახალი ფანჯარა
Name[kk]=Жаңа терезе
Name[km]=បង្អួចថ្មី
Name[kn]=ಹೊಸ ಕಿಟಕಿ
Name[ko]=새 창
Name[kok]=नवें जनेल
Name[ks]=نئئ وِنڈو
Name[lij]=Neuvo barcon
Name[lo]=ຫນ້າຕ່າງໃຫມ່
Name[lt]=Naujas langas
Name[ltg]=Jauns lūgs
Name[lv]=Jauns logs
Name[mai]=नव विंडो
Name[mk]=Нов прозорец
Name[ml]=പുതിയ ജാലകം
Name[mr]=नवीन पटल
Name[ms]=Tetingkap Baru
Name[my]=ဝင်းဒိုးအသစ်
Name[nb_NO]=Nytt vindu
Name[ne_NP]=नयाँ सञ्झ्याल
Name[nl]=Nieuw venster
Name[nn_NO]=Nytt vindauge
Name[or]=ନୂତନ ୱିଣ୍ଡୋ
Name[pa_IN]=ਨਵੀਂ ਵਿੰਡੋ
Name[pl]=Nowe okno
Name[pt_BR]=Nova janela
Name[pt_PT]=Nova janela
Name[rm]=Nova fanestra
Name[ro]=Fereastră nouă
Name[ru]=Новое окно
Name[sat]=नावा विंडो (N)
Name[si]=නව කවුළුවක්
Name[sk]=Nové okno
Name[sl]=Novo okno
Name[son]=Zanfun taaga
Name[sq]=Dritare e Re
Name[sr]=Нови прозор
Name[sv_SE]=Nytt fönster
Name[ta]=புதிய சாளரம்
Name[te]=కొత్త విండో
Name[th]=หน้าต่างใหม่
Name[tr]=Yeni pencere
Name[tsz]=Eraatarakua jimpani
Name[uk]=Нове вікно
Name[ur]=نیا دریچہ
Name[uz]=Yangi oyna
Name[vi]=Cửa sổ mới
Name[wo]=Palanteer bu bees
Name[xh]=Ifestile entsha
Name[zh_CN]=新建窗口
Name[zh_TW]=開新視窗

[Desktop Action new-private-window]
Exec=$HOME/Mozilla/firefox_esr32/firefox/firefox --private-window %%u --class FirefoxESR32
Name=New Private Window
Name[ach]=Dirica manyen me mung
Name[af]=Nuwe privaatvenster
Name[an]=Nueva finestra privada
Name[ar]=نافذة خاصة جديدة
Name[as]=নতুন ব্যক্তিগত উইন্ডো
Name[ast]=Ventana privada nueva
Name[az]=Yeni Məxfi Pəncərə
Name[be]=Новае акно адасаблення
Name[bg]=Нов прозорец за поверително сърфиране
Name[bn_BD]=নতুন ব্যক্তিগত উইন্ডো
Name[bn_IN]=নতুন ব্যক্তিগত উইন্ডো
Name[br]=Prenestr merdeiñ prevez nevez
Name[brx]=गोदान प्राइभेट उइन्ड'
Name[bs]=Novi privatni prozor
Name[ca]=Finestra privada nova
Name[cak]=K'ak'a' ichinan tzuwäch
Name[cs]=Nové anonymní okno
Name[cy]=Ffenestr Breifat Newydd
Name[da]=Nyt privat vindue
Name[de]=Neues privates Fenster
Name[dsb]=Nowe priwatne wokno
Name[el]=Νέο παράθυρο ιδιωτικής περιήγησης
Name[en_GB]=New Private Window
Name[en_US]=New Private Window
Name[en_ZA]=New Private Window
Name[eo]=Nova privata fenestro
Name[es_AR]=Nueva ventana privada
Name[es_CL]=Nueva ventana privada
Name[es_ES]=Nueva ventana privada
Name[es_MX]=Nueva ventana privada
Name[et]=Uus privaatne aken
Name[eu]=Leiho pribatu berria
Name[fa]=پنجره ناشناس جدید
Name[ff]=Henorde Suturo Hesere
Name[fi]=Uusi yksityinen ikkuna
Name[fr]=Nouvelle fenêtre de navigation privée
Name[fy_NL]=Nij priveefinster
Name[ga_IE]=Fuinneog Nua Phríobháideach
Name[gd]=Uinneag phrìobhaideach ùr
Name[gl]=Nova xanela privada
Name[gn]=Ovetã ñemi pyahu
Name[gu_IN]=નવી ખાનગી વિન્ડો
Name[he]=חלון פרטי חדש
Name[hi_IN]=नयी निजी विंडो
Name[hr]=Novi privatni prozor
Name[hsb]=Nowe priwatne wokno
Name[hu]=Új privát ablak
Name[hy_AM]=Սկսել Գաղտնի դիտարկում
Name[id]=Jendela Mode Pribadi Baru
Name[is]=Nýr huliðsgluggi
Name[it]=Nuova finestra anonima
Name[ja]=新しいプライベートウィンドウ
Name[ja_JP-mac]=新規プライベートウインドウ
Name[ka]=ახალი პირადი ფანჯარა
Name[kk]=Жаңа жекелік терезе
Name[km]=បង្អួចឯកជនថ្មី
Name[kn]=ಹೊಸ ಖಾಸಗಿ ಕಿಟಕಿ
Name[ko]=새 사생활 보호 모드
Name[kok]=नवो खाजगी विंडो
Name[ks]=نْو پرایوٹ وینڈو
Name[lij]=Nêuvo barcón privòu
Name[lo]=ເປີດຫນ້າຕ່າງສວນຕົວຂື້ນມາໃຫມ່
Name[lt]=Naujas privataus naršymo langas
Name[ltg]=Jauns privatais lūgs
Name[lv]=Jauns privātais logs
Name[mai]=नया निज विंडो (W)
Name[mk]=Нов приватен прозорец
Name[ml]=പുതിയ സ്വകാര്യ ജാലകം
Name[mr]=नवीन वैयक्तिक पटल
Name[ms]=Tetingkap Persendirian Baharu
Name[my]=New Private Window
Name[nb_NO]=Nytt privat vindu
Name[ne_NP]=नयाँ निजी सञ्झ्याल
Name[nl]=Nieuw privévenster
Name[nn_NO]=Nytt privat vindauge
Name[or]=ନୂତନ ବ୍ୟକ୍ତିଗତ ୱିଣ୍ଡୋ
Name[pa_IN]=ਨਵੀਂ ਪ੍ਰਾਈਵੇਟ ਵਿੰਡੋ
Name[pl]=Nowe okno prywatne
Name[pt_BR]=Nova janela privativa
Name[pt_PT]=Nova janela privada
Name[rm]=Nova fanestra privata
Name[ro]=Fereastră privată nouă
Name[ru]=Новое приватное окно
Name[sat]=नावा निजेराक् विंडो (W )
Name[si]=නව පුද්ගලික කවුළුව (W)
Name[sk]=Nové okno v režime Súkromné prehliadanie
Name[sl]=Novo zasebno okno
Name[son]=Sutura zanfun taaga
Name[sq]=Dritare e Re Private
Name[sr]=Нови приватан прозор
Name[sv_SE]=Nytt privat fönster
Name[ta]=புதிய தனிப்பட்ட சாளரம்
Name[te]=కొత్త ఆంతరంగిక విండో
Name[th]=หน้าต่างส่วนตัวใหม่
Name[tr]=Yeni gizli pencere
Name[tsz]=Juchiiti eraatarakua jimpani
Name[uk]=Приватне вікно
Name[ur]=نیا نجی دریچہ
Name[uz]=Yangi maxfiy oyna
Name[vi]=Cửa sổ riêng tư mới
Name[wo]=Panlanteeru biir bu bees
Name[xh]=Ifestile yangasese entsha
Name[zh_CN]=新建隐私浏览窗口
Name[zh_TW]=新增隱私視窗 " > Firefox_ESR32.desktop ;
# Both the name and file name should be different from the 64-bit editions.

# Give time for icon script to complete.
sleep 2;

# Makes icon executable allowing it to run Firefox (which is also executable).
chmod +x Firefox_ESR32.desktop ;

# Adds icon to application menu (xfce, gnome, cinnamon, mate, deepin, etc...).
cp Firefox_ESR32.desktop "$HOME"/.local/share/applications/ ;

# determine the XDG_DESKTOP_DIR, for multi language support!
DESKTOP_DIR=$(xdg-user-dir DESKTOP)

# Copies desktop icon to user desktop and grants them ownership (it is their desktop after all).
find "$DESKTOP_DIR" -maxdepth 1 -type d -exec cp Firefox_ESR32.desktop '{}' \; -exec chown --reference='{}' '{}/Firefox_ESR32.desktop' \;

# Removes the temporary files no longer needed.
rm "$file" ; rm Firefox_ESR32.desktop ;

# Exit notice.
printf -- '%s\n' "" "" "🎉 Congratulations! 🎉" \
    "Mozilla Firefox Extended Support Release has been successfully installed on your computer." \
    "From now on, Mozilla Firefox Extended Support Release will handle its own updates automatically." \
    "Enjoy your browsing experience with the latest features and improvements!" "" ""

# Exit
exit 0
