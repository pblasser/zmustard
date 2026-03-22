CC=-lua
DD=../temp/
PP=> $(DD)


main: clean
main: 
	lua hedr.lua 20 $(PP)20spiral.gcode
	lua hedr.lua 30 $(PP)30spiral.gcode
	lua hedr.lua 40 $(PP)40spiral.gcode


clean:
	-rm $(DD)*

