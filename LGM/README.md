#LGM Folder
The LGM folder is where all the good stuff is! :) This file lists out everything inside it that you need
to know about.

##Bin Folder
Short for "**Bin**aries." This folder contains all binary (Or "compiled.") versions of LÖVE Game Maker.
It's where you look when you just want to use LGM and get on with your life. ;)

##Src Folder
Short for "**S**ou**rc**e." This folder contains the actual source code behind LÖVE Game Maker.
It's where you look when you want to add stuff to the editor or just mess with the code. :)

##7zip Folder
This folder contains some pre-compiled executables from the fabulous [7-Zip Project](http://www.7-zip.org/).
It's used to archive the src folder's contents when building LGM binaries using "buildbinaries.bat." 

##README.md
...This file. :P

##testLGM.bat
This file is used in LÖVE Game Maker development to quick-ly test LÖVE Game Maker.

You can set it to run automatically when you press a key in Programmer's Notepad by going to
"Tools->Options->Project Tools", clicking "Add," setting "Command" to this file, "Folder" to
the folder this file is located in, and "Shortcut" to the key you want to press to launch LGM.

Now whenever you press the key you set, LÖVE Game Maker will launch, which is a huge time-saver! :D

##buildbinaries.bat
Oh boy! The biggie! :D

This is a mega batch file I've composed which automatically zips the contents of the src folder (Using 7-Zip.),
re-names the resulting LGM.zip file to LGM.love, appends that LGM.love file onto the 32-bit and 64-bit Windows
LÖVE builds (When given a path to them, of course. You must download them separatly.), copies the newly appended
executable as well as all the other files LÖVE needs to function to the appropriate folder within the bin folder,
and updates the pre-built MacOSX version of LÖVE Game Maker to the latest source found in the newly-created LGM.love file.

In brief, it allows you to build distributable versions of LÖVE Game Maker for 32-bit Windows, 64-bit Windows, and
Mac OSX all by simply double-clicking a file and pointing to 2 LÖVE directories (Which must be separatly installed.)!

This **VASTLY** speeds up the manual process of manually building LGM binaries, and allows you to push out new source
commits to the GitHub repository with binary builds included at an extremely pace! :D