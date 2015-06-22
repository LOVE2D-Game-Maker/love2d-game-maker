#!/bin/bash
# LÖVE Game Startup Script for Linux
# Josef Frank, 2014-2015 :: chikun.net

# Figure out working directory
SCRIPT_PATH=${0%/*}

# Save system library path for restoration
SYSTEM_LD_LIBRARY_PATH=$LD_LIBRARY_PATH

# Change library path to our own
export LD_LIBRARY_PATH="$SCRIPT_PATH/lib"

# Actually run the program
exec "$SCRIPT_PATH/bin/love" "$SCRIPT_PATH/bin/game.love" --fused "$@"

# Restore library path
export LD_LIBRARY_PATH="$SYSTEM_LD_LIBRARY_PATH"
