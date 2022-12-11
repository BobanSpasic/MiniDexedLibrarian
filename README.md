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

ToDo:
- send SysEx bulk dumps to MiniDexed
- edit DX7 voices
- import DX7II supplement (ACED/AMEM) and performances (PMEM)
- conversion of various 4OP voice files to DX7 format


The current state of the development can be tested on Windows 64-bit. The compiled files are in the BIN directory.

Linux Qt5:
![MDCC_Lin_Qt5](https://user-images.githubusercontent.com/68187526/206912419-a7c5030b-384e-4a50-96f4-b10689b12255.png)

Windows 10:
![MDCC_Win](https://user-images.githubusercontent.com/68187526/206912420-94a95b11-3b01-4602-bca4-869dbca8e1cf.png)

## Dependencies
Windows 64 - SQLite3 (dll included in download folder)
Linux Qt5 - libsqlite3, libportmidi, libQt5pas
Linux GTK2 - libsqlite3, libportmidi

## Compiling
Developed by using [Lazarus/Freepascal.](https://www.lazarus-ide.org/)

External components needed to build the MiniDexed Control Center are available through Lazarus OPM (Online Package Manager):
- ATShapeLine
- EyeCandyControls
- HashLib4Pascal



