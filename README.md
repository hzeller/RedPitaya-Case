A case for the RedPitaya
------------------------

A shielded case for the scope/function generator instrument from
http://redpitaya.com/.
The bare RedPitaya is just the board and without any shielding or protective
housing - this project attempts to remedy that.

The shield-metal-cut.ps PostScript file is the source for the shielding.
Print this on paper, glue on a thin (best tinned) iron shield metal and cut out.
Make sure that your printer program output is scaled 1:1.
The PostScript program is hand-written, so easy to modify (essentially
poor-mans parametric 2D CAD :) ).
If you notice that your printer does not scale the output properly (there is
a line of reference length in the printout), you can correct that directly in the
program, just change the actual length in the /measured-reference-length
variable. If you need a DXF file, create shield-metal-cut.dxf with the Makefile.

![Metal Case][metal-case]

(If you have a laser cutter or other means to automatically cut the shield,
please let me know what the best way is to provide a file that separates the
mechanical parts from the documentation text. Different color ?)

The OpenScad file plastic-case.scad is the source for the 3D objects.
These are the stand-offs and the actual case.
(The plastic-case.stl file is the binary result included in this distribution for
easy use).

![3D Print][design]

(The PostScript file is ready to use, the OpenScad file is still work in
progress, it only creates the stand-offs right now, no case).

![Assembled unit][assembled]

[metal-case]: https://github.com/hzeller/RedPitaya-Case/raw/master/img/metal-case.png
[assembled]: https://github.com/hzeller/RedPitaya-Case/raw/master/img/assembled.jpg
[design]: https://github.com/hzeller/RedPitaya-Case/raw/master/img/red-pitaya-case.png
