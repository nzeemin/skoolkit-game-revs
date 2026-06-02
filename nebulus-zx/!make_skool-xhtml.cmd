@echo off
rmdir /S /Q nebulus\images\udgs
C:\bin\skoolkit-10.0\sna2skool.py -H -c nebulus.ctl nebulus.z80 >nebulus.skool
C:\bin\skoolkit-10.0\skool2html.py nebulus.skool nebulus.ref -H -1 -a -q
echo DONE