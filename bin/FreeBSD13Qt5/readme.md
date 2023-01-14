FreeBSD
=======
I didn't provide any installation's package for FreeBSD as I dont' know how to create one.
The plain binary is distibuted.
Dependencies: Libc6, sqlite3, portmidi, Qt5Pas
Optional: alsa_seq_server to access MIDI ports.

Instructions from probonopd ( https://github.com/probonopd/MiniDexed/discussions/196#discussioncomment-4412689 ):

sudo pkg install qt5pas alsa-seq-server
sudo service alsa_seq_server enable
sudo service alsa_seq_server start

