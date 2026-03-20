@echo off
rmdir /S /Q joeblade\images\udgs
C:\bin\skoolkit-9.6\sna2skool.py -H -c joeblade.ctl joeblade.z80 >joeblade.skool
C:\bin\skoolkit-9.6\skool2html.py joeblade.skool joeblade.ref -H -1 -a -q
echo DONE