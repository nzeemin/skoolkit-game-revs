@echo off
rmdir /S /Q saboteur\images\udgs
C:\bin\skoolkit-9.6\sna2skool.py -H -c saboteur.ctl saboteur.z80 >saboteur.skool
C:\bin\skoolkit-9.6\skool2html.py saboteur.skool saboteur.ref -H -1 -a -q
echo DONE