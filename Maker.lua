

dofile("Tower.lua")



--gique,prespace,diameter,segments,turnsper
--b = Bottle:new(10,10)
--b.cz=0.5
--b.cz=1
--b:prelude()
--b:skimto(0,0)
--b:lineto(0,100,0)
--b:lineto(2,100,0)
--b:lineto(2,0,0)
t=Tuber:new(arg[1],arg[2],arg[3]/2,arg[4],arg[5],math.pi/10)
--t.cz=1
t:compile()
t:poslude()




