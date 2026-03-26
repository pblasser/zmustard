

dofile("Bottle.lua")

Tower={Pi=math.pi}
setmetatable(Tower,Bottle)
Tower.__index=Tower

function Tower:new(x,y,r)
 t=Bottle:new(x,y)
 setmetatable(t,self)
 t.radio=r 
 t.cth=0
 t:skimto(r,0)
 t:remember(r,0)
 --print("G2F"..self.Feed)
 t:basis(0.5)
 return t
end

function Tower:heightransfer(deth)
 dz = (deth/self.Pi)*self.Pitch/2
 return dz
 --self.cz = self.cz + dz
 --return cz
end

function Tower:ex(deth)
 de = deth*self.radio*self.Filament
 return de
end

function Tower:oiler(th)
 x=self.radio * math.cos(th)
 y=-self.radio * math.sin(th)
 return x,y
end

function Tower:_archto(th,z,e)
 self:spin(th)
 --print(th,z,e)
 x,y=self:oiler(self.cth)
 --self:spin(th)
 --z = (self.cz + dz) or heightransfer(th)
 s=self:stringer(2,"XYZIJE",3)

 s = string.format(self:stringer(2,"XYZIJE",3),
  self.dx+x,self.dy+y,z,-self.cx,-self.cy,e)
 print(s)
 --print("G2X"..x.."Y"..y.."Z"..z..
 -- "I"..(-self.cx).."J"..(-self.cy))
 self:remember(x,y)
end
function Tower:archto(th)
 self.cz = self.cz + self:heightransfer(th)
 self:_archto(th,self.cz,self:ex(th))
end

function Tower:spin(th)
 self.cth = self.cth + th
 self.cth = self.cth % (2*self.Pi)
end

function Tower:build(dz)
 sz=self.cz
 while (self.cz<sz+dz) do
  --self:spin(self.Pi)
  self:archto(self.Pi)
 end
end

function Tower:basis(place)
 self:_archto(self.Pi,place,self:ex(self.Pi))
 self:_archto(self.Pi,place,self:ex(self.Pi))
end

Turret={Hole=2}
setmetatable(Turret,Tower)
Turret.__index=Turret


function Turret:new(x,y,r,p)
 t=Tower:new(x,y,r)
 setmetatable(t,self)
 t.pattern=p 
 t.cp = 0
 return t
end

function Turret:dryarc(th,h)
 --tth=th/2
 dz = self:heightransfer(th)
 self:_archto(th/2,self.cz+h,0)
 self.cz=self.cz+dz
 self:_archto(th/2,self.cz,1/100)
end

function Turret:punch(dz)
 
 th=self.Hole/self.radio
 --print(th)
 sz=self.cz
 while (self.cz<sz+dz) do
  if self.cp ~= 0 then self:archto(self.cp) end
  self:dryarc(th,dz*2/3-self.cz+sz)
  self:archto(2*self.Pi-th-self.cp)
 end
 self.cp=self.cp+self.pattern
 
end

Tuber={}
setmetatable(Tuber,Turret)
Tuber.__index=Tuber

function Tuber:new(pre,rad,seg,tur,pat)
 p = pat or math.pi/5
 t=Turret:new(100,100,rad,p)
 setmetatable(t,self)
 t.pre=pre
 t.seg=seg
 t.tur=tur
 
 return t
end

function Tuber:compile()
 t:build(self.pre)
 for i=1,self.seg do
  t:punch(1)
  t:build(self.tur*self.Pitch)
 end
 t:punch(1)
 t:build(5)
 t:basis(self.cz)
 t:retact(10)
end

--prespace,diameter,segments,turnsper
b = Bottle:new(10,10)
b.cz=0.5
b:prelude()
b:skimto(0,0)
b:lineto(0,200,0)
b:lineto(2,200,0)
b:lineto(2,0,0)
t=Tuber:new(arg[1],arg[2]/2,arg[3],arg[4],math.pi/5)
t.cz=0.5
t:compile()
t:poslude()




