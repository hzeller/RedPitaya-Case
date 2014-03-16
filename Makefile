all: rpcase.stl shield-print.dxf

%.stl: %.scad
	openscad -o $@ -d $@.deps $<

 %.dxf: %.ps
	pstoedit -f "dxf_s:-polyaslines -mm" $< $@
