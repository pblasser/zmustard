CC=-lua
DD=../temp/
PP=> $(DD)


main: clean
main: 
	lua Tower.lua 2 5 100 2 45 $(PP)CW100-90.gcode
	lua Tower.lua 3 20 80 2 30 $(PP)CCW80-60.gcode
	lua Tower.lua 2 44 60 2 6 $(PP)CW60-12.gcode

	lua Tower.lua 2 10 50 2 13 $(PP)CW50-26.gcode
	lua Tower.lua 3 14 40 2 9 $(PP)CCW40-18.gcode
	lua Tower.lua 2 21 30 2 2 $(PP)CW30-4.gcode

clean:
	-rm $(DD)*

