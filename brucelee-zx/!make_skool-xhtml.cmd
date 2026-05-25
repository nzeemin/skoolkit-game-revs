@echo off
rmdir /S /Q brucelee\images\udgs
C:\bin\skoolkit-10.0\sna2skool.py -H -c brucelee.ctl brucelee.z80 >brucelee.skool
C:\bin\skoolkit-10.0\skool2html.py brucelee.skool brucelee.ref -H -1 -a -q
echo DONE