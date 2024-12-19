
// number of spikes in a circle.
steps = 24;

// radius of the underlying cylinder.  total
// radius will include spike height.
cylr  = 12;

// length of each spike
spikeh = 4;

// length of the spiked section.  this will
// get rounded down to be a multiple of the
// spike size.
zspikes = 76;


// height of the top piece
toph = 10;

// set to 1 to extend the cylinder with a hole for a keychain
// set to 0 to leave it out
inckeychain = 0;

// diameter of the keychain hole
keychain = 5;

// how many columns to include spikes on.  1 = every column,
// 2 = every other colum, and so on.  this will produce asymetrical
// results if it does not divide evenly into steps

spikecols = 2;

// a through hole, suitable for threading a rope through.  the value
// is a percentage of the cylinder size, or 0 to disable
throughhole = 0.75;

// slot diameter
slot = 6;

include <cylinder.scad>