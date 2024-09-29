#!/bin/bash
# Think pad
# We've got some extra buttons on the thinkpad above the trackpad. Let's remap them
#
# First lets find the ID
#
# ```
# xinput
# ```
#
# Virtual core pointer                          id=2    [master pointer  (3)]
#	⎜   ↳ Virtual core XTEST pointer                id=4    [slave  pointer  (2)]
#	⎜   ↳ SynPS/2 Synaptics TouchPad                id=10   [slave  pointer  (2)]
#	⎜   ↳ TPPS/2 IBM TrackPoint                     id=11   [slave  pointer  (2)] <---- This is the guy
#	⎣ Virtual core keyboard                         id=3    [master keyboard (2)]
#	    ↳ Virtual core XTEST keyboard               id=5    [slave  keyboard (3)]
#	    ↳ Power Button                              id=6    [slave  keyboard (3)]
#	    ↳ Video Bus                                 id=7    [slave  keyboard (3)]
#	    ↳ Sleep Button                              id=8    [slave  keyboard (3)]
#	    ↳ AT Translated Set 2 keyboard              id=9    [slave  keyboard (3)]
#	    ↳ ThinkPad Extra Buttons                    id=12   [slave  keyboard (3)] 
#
# ```
# xinput test 11
# ```
# LEFT=Button 1
# MIDDLE=Button 2
# RIGHT=Button 3 

# This first line should show the button mappings for the extra keys
xinput get-button-map 11

# Now button 1,2,3 are remaped to 11,12,13
xinput set-button-map 11 11 12 13 4 5 6 7


