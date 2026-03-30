pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
--bopl

function _init()
 poke(0x5f80,0)
 poke(0x5f81,1)
 set("x",1,0)
 set("x",2,0)
end

function _update()
 if btnp(🅾️) then poke(0x5f81,1) end
 if btnp(❎) then poke(0x5f81,2) end
 
 local plr_id=peek(0x5f81)
 
 if btnp(⬆️) then
  set("x",plr_id,
   get("x",plr_id)+1)
 end
 if btnp(⬇️) then
  set("x",plr_id,
   get("x",plr_id)-1)
 end
end

function _draw()
 if peek(0x5f81)==1 then
  cls(8)
 elseif peek(0x5f81)==2 then
  cls(11)
 else
  cls()
 end
 print(get("x",1))
 print(get("x",2))
end
-->8
--netcode

--20 bytes per player (5 plrs)
--4 bytes per land (6 lands)
--(in charge of player 1)
lookup={
 land_x=0x5f82,
 land_y=0x5f83,
 land_dim=0x5f84,
 --dir:2b,len:3b,radius:3b
 land_state=0x5f85,
 
 x=0x5f9a,
 y=0x5f9b,
 extra=0x5f9c,
 --dir/surface:3b,state:5b
 obj1_2_t=0x5f9d,
 obj2_3_t=0x5f9e,
 obj1_x1=0x5f9f,
 obj1_y1=0x5fa0,
 obj1_x2=0x5fa1,
 obj1_y2=0x5fa2,
 obj1_extra=0x5fa3,
 obj2_x1=0x5fa4,
 obj2_y1=0x5fa5,
 obj2_x2=0x5fa6,
 obj2_y2=0x5fa7,
 obj2_extra=0x5fa8,
 obj3_x1=0x5fa9,
 obj3_y1=0x5faa,
 obj3_x2=0x5fab,
 obj3_y2=0x5fac,
 obj3_extra=0x5fad
}

function get(key,section)
 if key[1]=="l" then
  return peek(lookup[key]+
   (section-1)*4)-64
 else
  return peek(lookup[key]+
   (section-1)*20)-64
 end
end

function set(key,section,value)
 if key[1]=="l" then
  return poke(lookup[key]+
   (section-1)*4,value+64)
 else
  return poke(lookup[key]+
   (section-1)*20,value+64)
 end
end

function get_land()
 local lands={}
 for i=1,7 do
  local land={
   x=get("land_x",i),
   y=get("land_y",i),
   dir=get("land_dir",i),
   len=get("land_len",i),
   r=get("land_r",i)
  }
  add(lands,land)
 end
 return lands
end
-->8
--room select

function init_room_s()
 room_id=0
 plr_id=0
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
