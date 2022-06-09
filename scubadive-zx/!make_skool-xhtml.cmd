rmdir /S /Q scuba\images\udgs
C:\bin\skoolkit-8.2\sna2skool.py -H -c scuba.ctl scuba.z80 >scuba.skool
C:\bin\skoolkit-8.2\skool2html.py scuba.skool scuba.ref -H -1 -a -q
