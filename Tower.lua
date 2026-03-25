


Bottle={Pitch=0.5,Filament=1/10,Feed=1500}

function Bottle:new(x,y)
 b = {cx=0,cy=0,cz=0,dx=x,dy=y}
 --print(self)
 setmetatable(b,self)
 self.__index = self
 return b
end

function Bottle:extrud(mm)
end
function Bottle:retact(mm)
 narg=-0.5
 self:extrud(narg)
 print("G0Z"..(self.cz+mm))
end

function Bottle:puddon()
 zerp=0
 self:extrud(zerp)
 print("G1Z"..self.cz)
end

function Bottle:skimto(x,y)
 self:retact(2)
 print("G0X"..x+self.dx.."Y"..y+self.dy.."F300")
 --self:update(x,y)
 self:puddon()
 print("G1F"..self.Feed)
end

function Bottle:lineto(x,y,dz)
 self.cz = self.cz + dz
 print("G1X"..x.."Y"..y.."Z"..self.cz)
 --self:update(x,y)
end

Tower={Pi=math.pi}
setmetatable(Tower,Bottle)
Tower.__index=Tower

function Tower:new(x,y,r)
 t=Bottle:new(x,y)
 setmetatable(t,self)
 t.radio=r
 t.cthet=0
 t:skimto(r,0)
 t:remember(r,0)
 return t
end

function Tower:remember(x,y)
 self.cx=x
 self.cy=y
 --self.cz=z
end 

function Tower:heightransfer(deth)
 return radio*(deth/Pi)*Pitch
end

function Tower:oiler(th)
end

function Tower:archto(th)
 x=math.sin
end





t=Tower:new(100,100,10)




