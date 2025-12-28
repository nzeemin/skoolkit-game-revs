rmdir /S /Q highwayencounter\images
C:\bin\skoolkit-9.6\sna2skool.py -H -c highwayencounter.ctl highwayencounter.z80 >highwayencounter.skool
C:\bin\skoolkit-9.6\skool2html.py highwayencounter.skool highwayencounter.ref -H -1 -a -q
