rpcase.stl:

%.stl: %.scad
	openscad -o $@ -d $@.deps $<
