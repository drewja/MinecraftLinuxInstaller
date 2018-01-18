#!/bin/sh

TmpDIR="/tmp/mc_build"
mkdir -p ~/bin
mkdir -p ~/usr/lib
wget -P $TmpDIR http://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar
wget -P $TmpDIR https://raw.githubusercontent.com/drewja/procname/master/procname.c
wget -P $TmpDIR https://raw.githubusercontent.com/drewja/procname/master/Makefile
make -C $TmpDIR all
cp $TmpDIR/libprocname.so ~/usr/lib/libprocname.so
cp $TmpDIR/Minecraft.jar ~/usr/lib/Minecraft.jar
make -C $TmpDIR clean

(
   printf '#!/bin/sh\n'
   printf 'LD_PRELOAD=~/usr/lib/libprocname.so PROCNAME=minecraft java -jar ~/usr/lib/Minecraft.jar\n'
) > ~/bin/minecraft
chmod +x ~/bin/minecraft

