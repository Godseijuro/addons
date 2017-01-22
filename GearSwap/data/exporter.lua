--[[
	Export Gear
	Exports the currently equipped gear in proper lua format to 
	Windower/addons/GearSwap/data/export/Playername_JOB_timestamp.lua
	Arguments, providable in any order:
	list		prints each item on a separate line (default is grouped)
	<set name>	uses the provided name as the name of the set
--]]
function export_gear(args)
	local header = 'sets.exported'
	local listfmt = false
	--Process provided arguments
	for _,arg in pairs(args) do
		if (arg:lower() == 'list') then
			listfmt = true
		else
			header = arg
		end
	end
	
	--Process currently equipped gear
	local slots = {'main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet'}
	local slotmap = {['left_ear']='ear1',['right_ear']='ear2',['left_ring']='ring1',['right_ring']='ring2'}
	local itemlist = windower.ffxi.get_items()
	
	local equipped = {}
	for _,slot in pairs(slots) do
		local index = itemlist.equipment[slot]
		if (index ~= 0) then
			local sname = slotmap[slot] or slot
			local bag = itemlist.equipment[slot..'_bag'] == 8 and 'wardrobe' or 'inventory'
			local itemid = itemlist[bag][index].id
			local item = res.items[itemid]
			equipped[sname] = item.enl:capitalize()
		end
	end

	--	==========	Write the file		==========

	if not windower.dir_exists(windower.addon_path..'data/export') then
		windower.create_dir(windower.addon_path..'data/export')
	end
    
	local path = 'data/export/'..player.name
	path = path..'_'..windower.ffxi.get_player().main_job
	path = path..os.date('_%Y.%m.%d_%H.%M.%S')
	if windower.file_exists(path..'.lua') then
		path = path..' '..os.clock()
	end
	
	local f = io.open(windower.addon_path..path..'.lua','w+')
	f:write(header..' = {\n')
	
	local comma = false
	local lastnl = false
	for i = 1, 16 do
		local slot = slots[i]
		local sname = slotmap[slot] or slot
		local iname = equipped[sname]
		
		if comma then
			f:write(',')
		end
		
		if (iname ~= nil) then
			f:write('\t'..sname..'="'..iname..'"')
			comma = true
			lastnl = false
		else
			comma = false
		end
		
		if listfmt or (i % 4 == 0) then
			if comma then
				f:write(',')
			end
			if not lastnl then
				f:write('\n')
				lastnl = true
			end
			comma = false
		end
		
	end
	
	f:write('}')
	f:close()
	atc('Successfully exported set to '..path..'.lua')
end