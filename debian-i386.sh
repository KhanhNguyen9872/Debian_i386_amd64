#debian_i386_khanhnguyen9872
termux-wake-lock
echo "termux-wake-lock" > ~/.bash_profile
pkg update -y && pkg upgrade -y && pkg install wget proot tar pv p7zip -y
cd 2> /dev/null
wget -O i386 https://raw.githubusercontent.com/KhanhNguyen9872/Debian_i386_amd64/main/i386 2> /dev/null
chmod 777 i386 2> /dev/null
sh i386
rm -f i386 2> /dev/null
exit
