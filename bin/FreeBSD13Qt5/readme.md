FreeBSD
=======
I didn't provide any installation's package for FreeBSD as I dont' know how to create one.
The plain binary is distibuted. 

After unpacking, open the shell/terminal in the directry where you unpacked the executable and execute the command
```
chmod +x MiniDexedCC
```
to set the executable attribute.

**Dependencies:** Libc6, sqlite3, portmidi, Qt5Pas

**Optional:** alsa_seq_server to access MIDI ports.



### Instructions to get MIDI ports working for MiniDexedCC

Thanks probonopd  https://github.com/probonopd/MiniDexed/discussions/196#discussioncomment-4412689
```
sudo pkg install alsa-seq-server
sudo service alsa_seq_server enable
sudo service alsa_seq_server start
```
