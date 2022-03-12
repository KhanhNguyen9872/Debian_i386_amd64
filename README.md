# Debian_i386_amd64
Run Debian i386 or amd64 on Android
# How to install

 - AMD64
```bash
wget -O debian-amd64.sh https://raw.githubusercontent.com/KhanhNguyen9872/Debian_i386_amd64/main/debian-amd64.sh 2> /dev/null && bash debian-amd64.sh && rm -f debian-amd64.sh
```

 - i386
```bash
wget -O debian-i386.sh https://raw.githubusercontent.com/KhanhNguyen9872/Debian_i386_amd64/main/debian-i386.sh 2> /dev/null && bash debian-i386.sh && rm -f debian-i386.sh
```

# Fix install package after 'apt update'
rm -f /var/lib/dpkg/info/$nomdupaquet*
