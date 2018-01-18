#!/bin/sh

TmpDIR="/tmp/mc_build"
mkdir -p $HOME/bin
mkdir -p $HOME/usr/lib

wget -P $TmpDIR https://raw.githubusercontent.com/drewja/procname/master/procname.c
wget -P $TmpDIR https://raw.githubusercontent.com/drewja/procname/master/Makefile

make -C $TmpDIR all
cp $TmpDIR/libprocname.so $HOME/usr/lib/libprocname.so

make -C $TmpDIR clean

wget -P $TmpDIR http://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar
cp $TmpDIR/Minecraft.jar $HOME/usr/lib/Minecraft.jar
rm -rf $TmpDIR

(
   printf '#!/bin/sh\n'
   printf 'LD_PRELOAD=$HOME/usr/lib/libprocname.so PROCNAME=minecraft java -jar $HOME/usr/lib/Minecraft.jar\n'
) > $HOME/bin/minecraft
chmod +x $HOME/bin/minecraft

(
    printf '[Desktop Entry]\n'
    printf 'Version=1.0\n'
    printf 'Type=Application\n'
    printf 'Name=Minecraft\n'
    printf 'Comment=\n'
    printf 'Exec='$HOME'/bin/minecraft\n'
    printf 'Icon=face-smile\n'
    printf 'Path=Desktop\n'
    printf 'Terminal=false\n'
    printf 'StartupNotify=false\n'
) > $HOME/Desktop/Minecraft.desktop
chmod +x $HOME/Desktop/Minecraft.desktop