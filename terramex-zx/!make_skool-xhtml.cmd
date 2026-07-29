@echo off
rmdir /S /Q terramex\images\udgs
C:\bin\skoolkit-10.0\sna2skool.py -H -c terramex.ctl terramex.z80 >terramex.skool
C:\bin\skoolkit-10.0\skool2html.py terramex.skool terramex.ref -H -1 -q
