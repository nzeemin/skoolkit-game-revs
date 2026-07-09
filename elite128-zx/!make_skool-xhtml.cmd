@echo off
set PYTHONIOENCODING=utf-8
rmdir /S /Q elite\images\udgs
C:\bin\skoolkit-10.0\sna2skool.py -H -c elite.ctl elite128.z80 >elite.skool
C:\bin\skoolkit-10.0\skool2html.py elite.skool elite.ref -H -1 -a -q
echo DONE