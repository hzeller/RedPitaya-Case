A case for the RedPitaya
------------------------

A shielded case for the scope/function generator instrument from
http://redpitaya.com/.
The bare RedPitaya is just the board and without any shielding or protective
housing - this project attempts to remedy that.

The shield-print.ps PostScript file is the source for the shielding.
Print this on paper, glue on a thin (best tinned) iron shield metal and cut out.
Make sure that your printer program output is scaled 1:1.
The PostScript program is hand-written, so easy to modify (essentially
poor-mans parametric 2D CAD :) ).
If you notice that your printer does not scale the output properly (there is
a line of reference length in the printout), you can correct that directly in the
program, just change the actual length in the /measured-reference-length
variable.

The OpenScad file rpcase.scad is the source for the 3D objects. These are the
stand-offs and the actual case.
(The rpcase.stl file is the binary result included in this distribution for
easy use).

(The PostScript file is ready to use, the OpenScad file is still work in
progress, it only creates the stand-offs right now, no case).
