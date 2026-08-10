@echo off
rmdir /S /Q flyingshark\images\udgs
C:\bin\skoolkit-10.0\sna2skool.py -H -c flyingshark.ctl FLSHARK.Z80 >flyingshark.skool
C:\bin\skoolkit-10.0\skool2html.py flyingshark.skool flyingshark.ref -H -1 -a -q
echo DONE