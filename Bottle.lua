Bottle={Pitch=0.5,Filament=1/10,Feed=1200}

function Bottle:new(x,y)
 b = {cx=0,cy=0,cz=0.5,dx=x,dy=y}
 --print(self)
 setmetatable(b,self)
 self.__index = self
 
 return b
end

function Bottle:prelude()
 print("G21G90") --mm abs

 print("M140 S67")
 print("M105")
 print("M190 S67")

 print("M104 S210")
print("M105")
print("M109 S210")

print("M83") --rel extr
print("G92 E0") --reset ext
print("G28") --home

print("M107") --fan off
print("G1F"..self.Feed)
print("G2F"..self.Feed)
end

function Bottle:poslude()
	print("M140 S0")-- ;bed cooler
print("M107")-- ;fan off
print("M106 S0")-- ;Turn-off fan
print("M104 S0")-- ;Turn-off hotend
print("M140 S0")-- ;Turn-off bed
--print("M84 X Y E")-- ;Disable all steppers but Z
print("M82")--
end 


function Bottle:fanner()
end

function Bottle:extrud(mm)
 print("G1E"..mm)
end
function Bottle:retact(mm)
 narg=-0.5
 self:extrud(narg)
 print("G0Z"..(self.cz+mm))
end

function Bottle:puddon()
 zerp=0.5
 self:extrud(zerp)
 print("G1Z"..self.cz)
end

function Bottle:stringer(g,s,p)
 local sd = "G"..g
 --print("ZOY")
 for i=1,string.len(s) do
  sd = sd..string.sub(s,i,i)
  sd = sd.."%."..p.."f"
 end
 return sd
end

function Bottle:skimto(x,y)
 self:retact(2)
 print("G0X"..x+self.dx.."Y"..y+self.dy.."F300")
 --self:update(x,y)
 self:puddon()
 --print("G1F"..self.Feed)
 self:remember(x,y)
end

function Bottle:remember(x,y)
 self.cx=x
 self.cy=y
 --self.cz=z
end 

function Bottle:ex(x,y)
 d = math.sqrt(x*x + y*y)
 dc = math.sqrt(self.cx*self.cx + self.cy*self.cy)
 return math.abs(dc-d) * self.Filament
end

function Bottle:lineto(x,y,dz)
 self.cz = self.cz + dz
 print("G1X"..x+self.dx.."Y"..y+self.dy.."Z"..self.cz.."E"..self:ex(x,y))
 self:remember(x,y)
end