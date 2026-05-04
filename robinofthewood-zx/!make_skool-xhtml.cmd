@echo off
rmdir /S /Q robin\images\udgs
C:\bin\skoolkit-10.0\sna2skool.py -H -c robin.ctl robin.mem >robin.skool
C:\bin\skoolkit-10.0\skool2html.py robin.skool robin.ref -H -1 -a -q
echo DONE