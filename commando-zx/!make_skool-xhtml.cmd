rmdir /S /Q commando\images\udgs
C:\bin\skoolkit-9.6\sna2skool.py -H -c commando.ctl commando.sna >commando.skool
C:\bin\skoolkit-9.6\skool2html.py commando.skool commando.ref -H -1 -a -q
