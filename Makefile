all: fab-print_case.stl fab-print_standoffs.stl shield-metal-cut.dxf

fab-print_case.stl:
fab-print_standoffs.stl:
shield-metal-cut.dxf:

%.stl: %.scad
	openscad -o $@ -d $@.deps $<

# Create an scad file on-the-fly that calls that particular function
fab-%.scad : plastic-case.scad
	echo "use <plastic-case.scad>; $*();" > $@

%.dxf: %.ps
	pstoedit -f "dxf:-polyaslines" $< $@
