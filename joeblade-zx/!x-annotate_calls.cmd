@echo off
C:\bin\skoolkit-10.0\sna2skool.py -H -c joeblade.ctl joeblade.z80 >joeblade.skool
echo Annotating calls...
py ..\annotate_calls.py --force joeblade.ctl joeblade.skool
