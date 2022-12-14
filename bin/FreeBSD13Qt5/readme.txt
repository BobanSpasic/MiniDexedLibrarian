Installation
============

Windows
=======
Create a folder for MiniDexed Control Center and unpack the files from the zip there.
At the first start, the MiniDexedCC will create a folder MiniDexedCC in the Users\UserName\ folder (e.g. c:\Users\JohnDoe\MiniDexedCC). All the settings and the database file SysExDB.sqlite are stored there.


Linux
=====
Install the DEB file by using your preferred method.
Settings and database are stored the directory MiniDexedCC under the home directory of the current user.
Dependencies: Libc6, sqlite3, portmidi, libQt5Pas (if you are using the Qt5 version)

Note: libQt5pas distributed with Ubuntu and derivates is know to cause problems. 
Please use the builds from David Bannon: https://github.com/davidbannon/libqt5pas/releases
For Linux on 64-bit PC, you'll need libqt5pas1_2.11-1_amd64.deb


FreeBSD
=======
I didn't provide any installation's package for FreeBSD as I dont' know how to create one.
The plain binary is distibuted. After downloading, set the executable attributes.
Settings and database are stored the directory MiniDexedCC under the home directory of the current user.
Dependencies: Libc6, sqlite3, portmidi, Qt5Pas