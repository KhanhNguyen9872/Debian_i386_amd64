#!/data/data/com.termux/files/usr/bin/bash
pkg update -y && pkg upgrade -y && pkg install wget proot tar pv p7zip -y
chroot=ubuntu-fs64
if [ -d "$chroot" ]; then
	a=1
	echo "Skip Download!"
fi
khanh="debian-rootfs.tar.xz"
if [ "$a" != 1 ];then
	if [ ! -f $khanh ]; then
		echo "Dang tai ve....."
		case `dpkg --print-architecture` in
		aarch64)
			wget -O qemu-x86_64-static https://raw.githubusercontent.com/KhanhNguyen9872/Debian_i386_amd64/main/arm64/qemu-x86_64-static 2> /dev/null;
			chmod 777 qemu-x86_64-static;
			mv qemu-x86_64-static ~/../usr/bin ;;
		arm)
			wget -O qemu-x86_64-static https://raw.githubusercontent.com/KhanhNguyen9872/Debian_i386_amd64/main/arm/qemu-x86_64-static 2> /dev/null;
			chmod 777 qemu-x86_64-static;
			mv qemu-x86_64-static ~/../usr/bin/ ;;
		*)
			;;
		esac
		wget -O $khanh https://github.com/KhanhNguyen9872/Debian_i386_amd64/releases/download/debianrootfs/debian-rootfs-amd64.tar.xz
	fi
	cur=`pwd`
	mkdir -p "$chroot"
	cd "$chroot"
	clear
	echo ""
	echo "Dang cai dat...."
	proot --link2symlink tar -xJf ${cur}/${khanh}||:
	cd "$cur"
fi
mkdir -p debian-binds
LAUNCHER=debian.sh
cat > $LAUNCHER <<- EOM
#!/bin/bash
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $chroot -q qemu-x86_64-static"
command+=" -b /dev"
command+=" -b /proc"
command+=" -b /sdcard"
command+=" -b /vendor"
command+=" -b /system"
command+=" -b /data"
command+=" -b /mnt"
command+=" -b /storage"
command+=" -b /product"
command+=" -b ubuntu-fs64/root:/dev/shm"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

termux-fix-shebang $LAUNCHER
mv $LAUNCHER ${PREFIX}/bin/debian
chmod 777 ${PREFIX}/bin/debian
cd 2> /dev/null
rm -f $khanh
echo "You can now launch Debian with the ./${LAUNCHER} script"
