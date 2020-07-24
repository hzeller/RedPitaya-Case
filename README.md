A case for the RedPitaya
------------------------

A shielded case for the scope/function generator instrument from
http://redpitaya.com/.
The bare RedPitaya is just the board and without any shielding or protective
housing - this project attempts to remedy that. This is on [YouMagine][youmagine-design] (also thingiverse 278113).

The `shield-metal-cut.ps` PostScript file is the source for the shielding.
Print this on paper, glue on a thin (best tinned) iron shield metal (like from an old consumer device or something like a can with flat tinned metal, e.g. an empty paint thinner can) and cut out.
Make sure that your printer program output is scaled 1:1 (some PDF readers add
a margin to the page and scale the rest).
The PostScript program is hand-written, so easy to modify (essentially
poor-mans parametric 2D CAD :) ).
If you notice that your printer does not scale the output properly (there is
a line of reference length in the printout), you can correct that directly in the
program, just change the actual length in the [`/measured-reference-length`][reference-len]
variable.

If you need a DXF file, create shield-metal-cut.dxf with the Makefile (`make shield-metal-cut.dxf`). Documentation text is written in blue and shows up as
separate channel in the DXF.

Top                                   | Bottom
--------------------------------------|------------------------------------
![Top Case](./img/metal-case-top.png) | ![Metal Case](./img/metal-case.png)

![Physical](./img/drilled-metal.jpg)

The OpenScad file plastic-case.scad is the source for the 3D objects.
These are the stand-offs and the actual case.
(The [`plastic-case.stl`](./plastic-case.stl) file is the binary result included in this distribution for easy use). This is the first shot; if you have improvements, just send me a pull-request.

![3D Print][design]

The top part of the case will just be attached with the heat staking technique found in many consumer devices.

![Attached with heat-stake][melt-attached]

The final case looks like this; the arrows show input/outputs.
![Assembled unit][assembled]

![Assembled unit bottom](./img/bottom.jpg)

[reference-len]: https://github.com/hzeller/RedPitaya-Case/blob/master/shield-metal-cut.ps#L24
[metal-case]: ./img/metal-case.png
[melt-attached]: ./img/melt-attached.jpg
[assembled]: ./img/assembled.jpg
[design]: ./img/red-pitaya-case.png
[youmagine-design]: https://www.youmagine.com/designs/shielded-redpitaya-case
[thing278113]: http://www.thingiverse.com/thing:278113
