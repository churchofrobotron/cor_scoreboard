# Church of Robotron Scoreboard

## Summary

This is the latest scoreboard code for the [Church of Robotron](http://churchofrobotron.com).  It is written using
[BGFX](https://github.com/bkaradzic/bgfx) and is targetted at OSX and the Raspberry PI.

![Image of scoreboard in action](scoreboard.jpg)

## Setup/Run

1. Build instructions.
   1. This project uses [Genie](https://github.com/bkaradzic/GENie) like BGFX to keep things easy. Run GENie like so:
      1. `./thirdparty/bx/tools/bin/darwin/genie --gcc=osx make` to get makefiles.
      s2. `./thirdparty/bx/tools/bin/darwin/genie --gcc=osx xcode` to get an XCode project.
   2. Run `make -C build/make` to build with makefiles.
2. Create a symbolic link to leaderboard/data in the runtime directory so the scoreboard knows where the score data is.
3. Run with runtime/ as the current working directory.
