@echo off
C:\bin\skoolkit-10.0\sna2skool.py -H -c hydrofool.ctl hydrofool.sna >hydrofool.skool
C:\bin\skoolkit-10.0\skool2html.py hydrofool.skool hydrofool.ref -H -1 -q
