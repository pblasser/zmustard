

dofile("Tower.lua")



hole=math.pi/30
spro=math.pi/30

t=Turret:new(100,100,25,2,0)

t:build(10)
for i=1,9 do
  t:dryarc(hole)
  t:archto(spro)
 end
t:archto(math.pi*2-(hole+spro)*9)
t:build(5)
  t:dryarc(hole)
  t:archto(spro)
  t:build(13)

  t:dryarc(hole)
  t:archto(spro)
  t:build(13)

  t:dryarc(hole)
  t:archto(spro)
  t:build(10)
 t:basis(t.cz)


t:poslude()