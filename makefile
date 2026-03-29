CC=-lua
DD=../temp/
PP=> $(DD)


main: clean
main: 
	lua Tower.lua 5 20 2 5 $(PP)30-33.gcode
	lua Tower.lua 10 20 2 33 $(PP)20-33.gcode

clean:
	-rm $(DD)*

