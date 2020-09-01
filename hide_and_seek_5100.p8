pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--hide and seek 5100
--by jeff adams
--a game by its cover jam 2020
--inspired by the artwork of
--metehan korkmazel

function _init()
	debug={}
	fading=0
	change_state(update_menu,draw_menu)
	init_players()
end

function _update()
	ustate()
end

function _draw()
	cls()
	dstate()
	if debug then draw_debug(0,0) end
end

function init_players()
	numplayers=1
	players={
		{
			x=0,
			y=0,
			dirx=0,
			diry=0,
			c=12,
			speed=1,
			alive=true,
		},
		{
			x=120,
			y=0,
			dirx=0,
			diry=0,
			c=14,
			speed=1,
			alive=true,
		},
		{
			x=0,
			y=120,
			dirx=0,
			diry=0,
			c=8,
			speed=1,
			alive=true,
		},
		{
			x=120,
			y=120,
			dirx=0,
			diry=0,
			c=9,
			speed=1,
			alive=true,
		},
	}
end
-->8
--update

function update_menu()
	if btnp(➡️) then
		numplayers=min(#players,numplayers+1)
		add_debug("players",numplayers,2)
	end
	if btnp(⬅️) then
		numplayers=max(1,numplayers-1)
		add_debug("players",numplayers,2)
	end
	if btnp(❎) then
		players=subtable(players,1,numplayers)
		--change state to game
	end
end
-->8
--draw

function draw_menu()
	print("menu",58,64,7)
end
-->8
--utilities

function add_debug(_k,_v,_dur)
	_dur=_dur and _dur or 1
	debug[_k]={val=_v,frames=_dur*stat(8)}
end

function draw_debug(_x,_y)
	local _title,_c="debug",11
	local _lines,_max={},#_title
	--create the message and 
	--get the biggest message
	for k,v in pairs(debug) do
		if v.frames>0 then
			local _line=k..": "..v.val
			_max=#_line>_max and #_line or _max
			add(_lines,_line)
			v.frames-=1
		else
			del(debug,k)
		end
	end
	if #_lines>0 then
		local _offset=10
		rectfill(_x,_y,_x+_max*4+4,_y+#_lines*6+_offset+6,5)
		print(_title,_x+2,_y+2,_c)
		for i=1,#_lines do
			print(_lines[i],_x+2,i*6+_y+_offset,_c)
		end
	end
end

function shuffle(objs)
	for i=#objs,2,-1 do
		local j=flr(rnd(i))+1
		objs[i],objs[j]=objs[j],objs[i]
	end
	return objs
end

function printc(_text,_y,_c,_oc)
	local _x=(127-#_text/2*8)/2
	if _oc then
		printo(_text,_x,_y,_c,_oc)
	else
		print(_text,_x,_y,_c)
	end
end

function printo(_text,_x,_y,_c,_oc)
	print(_text,_x+1,_y-1,_oc)
	print(_text,_x+1,_y,_oc)
	print(_text,_x+1,_y+1,_oc)
	print(_text,_x,_y+1,_oc)
	print(_text,_x-1,_y+1,_oc)
	print(_text,_x-1,_y,_oc)
	print(_text,_x-1,_y-1,_oc)
	print(_text,_x,_y-1,_oc)
	print(_text,_x,_y,_c)
end

--function by dw817 on bbs
function fadeout()
	local _fadespeed=4
	local _fade,_c,_p={[0]=0,17,18,19,20,16,22,6,24,25,9,27,28,29,29,31,0,0,16,17,16,16,5,0,2,4,0,3,1,18,2,4}
	fading+=1
	if fading%_fadespeed==1 then
		for i=0,15 do
			_c=peek(24336+i)
			if (_c>=128) _c-=112
				_p=_fade[_c]
				if (_p>=16) _p+=112
					pal(i,_p,1)
				end
				if fading==7*_fadespeed+1 then
					cls()
					pal()
					fading=0
		end
	end
end

function change_state(_update,_draw)
	previous={update=update_state,draw=draw_state}
	ustate=_update
	dstate=_draw
end

function previous_state()
	local _p=previous
	change_state(_p.update,_p.draw)
end

function subtable(_tbl,_s,_e)
	local _subtbl={}
	for i=_s,_e do
		add(_subtbl,_tbl[i])
	end
	return _subtbl
end
-->8
--event



__gfx__
00000000bbffffbb90000000bb8888bb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bffffffb99000000b888888b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700f0f0ffffa900000088888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000ffffffffa990000088888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000ffffffffa999000088888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700ffffffffa999000088888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bffffffbaa999000b888888b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbffffbbaa999900bb8888bb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaaaaa99999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaaaaa99999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaaa9999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aaaaaaaaaaa9999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000aaaaaaaaa9999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000aaaaaa9990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000aaaaa990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
