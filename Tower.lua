

Bottle={Pitch=0.5,Filament=1/10,Feed=1500}

function Bottle:new(x,y)
 b = {cx=0,cy=0,cz=0,dx=x,dy=y}
 --print(self)
 setmetatable(b,self)
 self.__index = self
 self:prelude()
 return b
end

function Bottle:prelude()
 print("G21G90")
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
 print("G1X"..x+self.dx.."Y"..y+self.dy.."Z"..self.cz)
 --self:update(x,y)
end

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
 print("G2F"..self.Feed)
 t:basis()
 return t
end

function Tower:remember(x,y)
 self.cx=x
 self.cy=y
 --self.cz=z
end 

function Tower:heightransfer(deth)
 dz = (deth/self.Pi)*self.Pitch
 self.cz = self.cz + dz
 return cz
end

function Tower:oiler(th)
 x=self.radio * math.cos(th)
 y=self.radio * math.sin(th)
 return x,y
end

function Tower:_archto(th,z)
 x,y=self:oiler(th)
 --self:spin(th)
 --z = (self.cz + dz) or heightransfer(th)
 s = string.format("G2X%.4fY%.4fZ%.4fI%.4fJ%.4f",
  self.dx+x,self.dy+y,z,-self.cx,-self.cy)
 print(s)
 --print("G2X"..x.."Y"..y.."Z"..z..
 -- "I"..(-self.cx).."J"..(-self.cy))
 self:remember(x,y)
end
function Tower:archto(th)
 self:heightransfer(th)
 self:_archto(th,self.cz)
end

function Tower:spin(th)
 self.cth = self.cth + th
 self.cth = self.cth % (2*self.Pi)
end

function Tower:build(dz)
 sz=self.cz
 while (self.cz<sz+dz) do
  self:spin(self.Pi)
  self:archto(self.cth)
 end
end

function Tower:basis()
 self:spin(self.Pi)
 self:_archto(self.cth,0)
 
 self:spin(self.Pi)
 self:_archto(self.cth,0)
end




t=Tower:new(100,100,10)
t:build(100)




