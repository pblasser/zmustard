CC=-lua
DD=../temp/
PP=> $(DD)


main: clean
main: 
	lua Tower.lua 20 $(PP)20spiral.gcode

clean:
	-rm $(DD)*

