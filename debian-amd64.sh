#kali_arm64_khanhnguyen9872
termux-wake-lock
echo "termux-wake-lock" > ~/.bash_profile
pkg update -y && pkg upgrade -y && pkg install wget proot tar pv p7zip -y
cd 2> /dev/null
wget -O amd64 https://raw.githubusercontent.com/KhanhNguyen9872/Debian_i386_amd64/main/amd64 2> /dev/null
chmod 777 amd64 2> /dev/null
sh amd64
rm -f amd64 2> /dev/null
exit
