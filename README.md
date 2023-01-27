# MiniDexedLibrarian
This project's target is to produce a librarian/editor for [MiniDexed](https://github.com/probonopd/MiniDexed) - 8x Dexed on bare metal Raspberry Pi.

As a side-effect, it can also be used as a librarian for Yamaha DX7/TX816.

## MiniDexed Control Center
The project binaries will be distributed under the name **MiniDexed Control Center**

Working:
- open/combine/save DX7 SysEx bulk dumps (Voice banks)
- open/edit/save MiniDexed performance.ini files
- open/edit/save MiniDexed minidexed.ini configuration files
- sending voice bulk dumps (banks) to Dexed (not to MiniDexed)
- sending single voices
- save/open current state on closing/opening the app
- organize SysEx and performance files on MiniDexed SD Card
- store collections to SQL-DB (eliminating duplicates etc.)
- import DX7II supplement (ACED/AMEM) and performances (PMEM)

ToDo:
- send SysEx bulk dumps to MiniDexed (Feature missing in MiniDexed)
- edit DX7 voices (Not a priority. There are a lot of DX7-Editors on the net)
- conversion of various 4OP voice files to DX7 format (Low priority. Alternative: DXconvert from http://dxconvert.martintarenskeen.nl/ )



Linux Qt5:
![MDCC_Lin_Qt5](https://user-images.githubusercontent.com/68187526/206912419-a7c5030b-384e-4a50-96f4-b10689b12255.png)

Windows 10:
![MDCC_Win](https://user-images.githubusercontent.com/68187526/206912420-94a95b11-3b01-4602-bca4-869dbca8e1cf.png)

FreeBSD 13:  
![MDCC_FreeBSD](https://user-images.githubusercontent.com/2480569/207942721-f913b43e-6b71-422f-b776-1a625e0ff62b.png)

OSX (Darwin):
![MDCC_OSX](https://user-images.githubusercontent.com/68187526/215217790-3d76eb06-bdf6-40da-9755-fa9509ce0739.png)

## Dependencies
Windows 64 - SQLite3 (dll included in download)

Linux Qt5 - Libc6, sqlite3, portmidi, libQt5Pas

Linux GTK2 - Libc6, sqlite3, portmidi

FreeBSD - Libc6, sqlite3, portmidi, Qt5Pas and optional alsa_seq_server to access MIDI ports.

## Compiling
Developed by using [Lazarus/Freepascal.](https://www.lazarus-ide.org/)

External components needed to build the MiniDexed Control Center are available through Lazarus OPM (Online Package Manager):
- ATShapeLine
- EyeCandyControls
- HashLib4Pascal
- IndustrialStuff

## Linux notes
libQt5pas distributed with Ubuntu and derivates is know to cause problems. 

Please use the builds from David Bannon: https://github.com/davidbannon/libqt5pas/releases

For Linux on 64-bit PC, you'll need libqt5pas1_2.11-1_amd64.deb 

## Windows notes
On Windows, the PortMidi library is not used. I did't found any working 64-bit version of portmidi.dll on the internet.
It means, MIDI on Windows is accessed through native Windows' MultiMedia System (MMSYSTEM).
