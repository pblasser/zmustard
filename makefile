CC=-lua
DD=../temp/
PP=> $(DD)


main: clean
main: 
	lua Tower.lua 2 5 100 2 45 $(PP)CW100-90.gcode
	lua Tower.lua 3 10 80 2 30 $(PP)CCW80-60.gcode

clean:
	-rm $(DD)*

