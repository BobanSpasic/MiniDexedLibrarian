# MiniDexedLibrarian
This project's target is to produce a librarian/editor for MiniDexed: https://github.com/probonopd/MiniDexed

## MiniDexed Control Center
The project binaries will be distributed under the name MiniDexed Control Center

Working:
- open/combine/save DX7 SysEx bulk dumps (Voice banks)
- open/edit/save MiniDexed performance.ini files
- open/edit/save MiniDexed minidexed.ini configuration files
- sending voice bulk dumps (banks) to Dexed (not to MiniDexed)
- save/open current state on closing/opening the app

ToDo:
- organize SysEx and performance files on MiniDexed SD Card
- send SysEx bulk dumps to MiniDexed
- store collections to SQL-DB (eliminating duplicates etc.)
- edit DX7 voices
- import DX7II supplement (ACED/AMEM) and performances (PMEM)
- conversion of various 4OP voice files to DX7 format
- rendering artefacts on GUI (text colors problems with Windows Themes)
- Linux and MacOS versions

The current state of the development can be tested on Windows 64-bit. The compiled files are in the BIN directory.

![screen2](https://user-images.githubusercontent.com/68187526/178163001-3e88828b-6c6c-42ed-a54d-ce3d169eb028.jpg)

![screen20220704](https://user-images.githubusercontent.com/68187526/177214738-78d8b019-6be4-42a1-8a22-6bbe6c2276cc.png)

![screen1](https://user-images.githubusercontent.com/68187526/178163010-8108f7ed-37da-4dff-be30-7b929a1eb6e7.jpg)

## Compiling
Developed by using [Lazarus/Freepascal.](https://www.lazarus-ide.org/)

External components needed to build the MiniDexed Control Center are available through Lazarus OPM (Online Package Manager):
- ATShapeLine
- EyeCandyControls
- JPPack
- pl_Cindy

