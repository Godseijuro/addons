-- TODO: in function that auto registers agroed mobs to list, add in removal if defeated mob is on the list.  Also add a timer that removes the ID if its still in list after 10~15min


-- variables
KillSwitch = false -- Master Kill switch to disable everything
ChangeCamp = false -- this triggers prep for moving, and then if all conditions are met, calls controller_movement()
MovingCamp = false -- true when actually moving to a new camp
CurrentCamp = 'Entrance' -- can be 'TE1', 'TE2', 'TE3', 'TE4', 'TE5', 'Camp00', 'Camp08', 'Camp16', 'Entrance', & 'Exit'

TE = { false, false, false, false, false } -- probably better, easier to iterate if needed
FullParty = false
Party = {}

-- Refreshed whenever function repeats, used to help random number generation
RandomSeed = 0

-- This works, could be more efficient
--Player = {
--	name = '',
--	id = 0,
--	index = 0,
--}
PlayerName = ''
PlayerIndex = 0
PlayerID = 0
PlayerStatus = 'idle'

AgroedMobs = {}

-- toggled with 'gs c makemap' and used in mapping routes, auto logs position every *3 seconds
TestPosition = 'OFF'

CurrentWaypoint = 1
TotalWaypoints = 0
Route = {}

-- To TE1
Route[1] = {

}
-- To TE2
Route[2] = {

}
-- To TE3
Route[3] = {

}
-- To TE4
Route[4] = {

}
-- To TE5
Route[5] = {

}
-- To Camp from TE5
Route[6] = {

}

send_command('bind f12 gs c killswitch')
send_command('bind f11 gs c makemap')

--------------------------------------------------------------------------------
-- Master function that controls everything when called (where the magic happens)
--------------------------------------------------------------------------------

-- TODO: can use self commands to put certain variables on a timer, so that they get changed after a certain wait time, good to periodically check things
-- at the end of every possible scenario, should eliminate loops since repeatedly running, if a condition isnt met, it should just end!!!
-- possibly middleware injection
function start_flow()
	if KillSwitch then
		print('Kill Switch [ON]: stopping all Processes')
	else
		if midaction() then
			print('currently in mid-action, waiting until complete')
		else
			controller_refresh_globals()
			if CurrentCamp == 'Entrance' then
				if not ChangeCamp then
					print('CurrentCamp = ', CurrentCamp, ' & ChangeCamp = ', ChangeCamp, '--- Calling controller_entered_dynamis()')
					controller_entered_dynamis()
				else
					print('CurrentCamp = ', CurrentCamp, ' & ChangeCamp = ', ChangeCamp, '--- Calling controller_movement()')
					controller_movement()
				end
			elseif CurrentCamp == 'TE5' then
				if not ChangeCamp then
					print('CurrentCamp = ', CurrentCamp, ' & ChangeCamp = ', ChangeCamp, '--- Calling controller_movement()')
					controller_battle()
					controller_movement()
				else
					print('CurrentCamp = ', CurrentCamp, ' & ChangeCamp = ', ChangeCamp, '--- Calling controller_movement()')
					controller_movement()
				end
			end
		end
		-- TODO: for production, the wait time should either go away or be extremely low, just set to wait time now to slow things down enough to debug
		send_command('wait .5;gs c startflow')
	end
end

--------------------------------------------------------------------------------
-- Controllers (these are called by 'start_flow()' and call other sub-functions)
--------------------------------------------------------------------------------
function controller_refresh_globals()
	get_player_info()
	check_for_time_extensions()
	get_party_info()
	refresh_random_seed()
	print('--- Globals Refreshed ---')
	print('Player info: ', PlayerName, PlayerIndex, PlayerID)
	print('FullParty: ', FullParty)
	print('Party list of IDs: ', Party[0], Party[1], Party[2], Party[3], Party[4], Party[5])
	print('TimeExtensions: ', TE[1], TE[2], TE[3], TE[4], TE[5])
end

function controller_battle()
	if PlayerStatus == 'engaged' then
		target = windower.ffxi.get_mob_by_target('t')
		if have_all_TE() then
			print('have all TE\'s so using procs if target is nightmare mob')
		end
	elseif CurrentCamp == 'TE5' and not TE[5] and TE_close() then
		target = get_closest_TE(5)
	end
end

-- returns true of false if a TE mob is close by
function TE_close(key)
	local closestTE = get_closest_TE(key)
	if closestTE then
		return true
	else
		return false
	end
end

-- claim_id and target_index are a thing
-- target_index supposedly only valid for PCs
-- TODO: if mob has target_index that is not current player or party member, then wait for respawn, or keep running along path
function get_closest_TE(key)
	local t = {}
	if key == 5 then
		-- TODO: replace these with actual TE's ID's
		t[1] = windower.ffxi.get_mob_by_id(17199366)
		--t[2] = windower.ffxi.get_mob_by_id(17199366)
		--t[3] = windower.ffxi.get_mob_by_id(17199366)
		--t[4] = windower.ffxi.get_mob_by_id(17199366)
		for key, value in pairs(t) do
			--if value.name == 'Goblin Leecher' and value.distance < 2800 then
			--	print('------- TE Detected ------')
			--	print('------- ', value.name, key, 'distance: ', value.distance, 'pos: (', value.x, ',', value.y, ')')
			print(value.status)
			table.vprint(value)

			-- movement progression when TE mob is detected TODO: these numbers should be randomized within range in movement functions
			if value.distance > 200 then
				follow_waypoints(value.x, value.y)
			elseif value.distance > 30 and value.distance < 200 then
				windower.ffxi.follow(value.index)
			elseif value.distance < 30 then
				windower.ffxi.follow()
				send_command('setkey f8;setkey f8 up;wait .5;input /attack')
			end
		end
	end
	--for k,v in pairs(value) do
	--table.print(key, value) end
end

-- Controller for initial Dynamis entry
-- need to call trusts, sneak invis, change state to TE1, send maestro for warp & ezfarm activation
-- TODO: probably combine this with controller_movement
function controller_entered_dynamis()
	print(166, 'called function controller_entered_dynamis()')
	summon_trusts()
	if FullParty then
		ChangeCamp = true
	end
end

-- Move to new Camp
-- executed when idle or buff changes and ChangeCamp Variable is "ON"
-- executes next function if invisible for at least 5 seconds to make sure out of agro
-- could optionally pass in buff here
function controller_movement()
	print('called function controller_movement()')

	-- checks to see if you have all the time extensions
	if TE[1] and TE[2] and TE[3] and TE[4] and TE[5] then
	--[[
		print(166, 'Congrats you have all the Time Extensions....')
		if world.time < 480 then
			print('Moving to Camp 00')
			if CurrentCamp == 'Camp 16' then
			end
			if CurrentCamp == 'TE5' then
				route = RouteTE5toCamp00
				for key, value in pairs(route) do
					--	****going to have to use iparis to keep in right order, but key must be sequencial integers, so consider 1 = {4,5} and so on
					run_to_pos(key, value)
				end
				MovingCamp = false
				CurrentCamp = Camp00
			end -- then after all waypoints done trigger movingcamp = false and start route for inside camp
		elseif world.time < 960 then
			print('Moving to Camp 08')
			windower.copy_to_clipboard('camp 08')
		else
			print('Moving to Camp 16')
			windower.copy_to_clipboard('camp 16')
		end
	--]]
	
		-- Random
	elseif not TE[5] then
		local route = Route[5]
		CurrentCamp, ChangeCamp, MovingCamp = 'TE5', false, false
		print('Calling follow_waypoints() for TE5')
		if FullParty then
			if player_invisible() then
				follow_waypoints(route)
			else
				send_command('input /ja "Spectral Jig" <me>')
				print('Full party, but not invisible, applying the jig')
			end
		else
			summon_trusts()
		end

		-- Orc
	elseif not TE[1] then
		print('Moving to TE1')
		windower.copy_to_clipboard('TE[1]')

		-- Quadav
	elseif not TE[2] then
		print('Moving to TE4')
		windower.copy_to_clipboard('TE[2]')

		-- Goblin
	elseif not TE[4] then
		print('Moving to TE4')
		windower.copy_to_clipboard('TE[4]')

		-- Yagudo
	elseif not TE[3] then
		print('Moving to TE3')
		windower.copy_to_clipboard('TE3')
	end
end


--function test(arraytable)
--	table.vprint(arraytable)
--end

-- Exited
-- reset all variables
-- Transfer all currency to other bags?
function exited_dynamis()
	print(166, 'called function exited_dynamis()')
	windower.copy_to_clipboard('out of dynamis')
	CurrentCamp = 'Exit'
	ChangeCamp = false
	TE[1] = false
	TE[2] = false
	TE[3] = false
	TE[4] = false
	TE[5] = false
end

-- Character dies
function i_am_dead()
	print(166, 'called function i_am_dead()')
	windower.copy_to_clipboard('i am dead')
end

--	function run_to_pos(key, value)
--		local posx, posy = get_current_pos()
--		if posx ~= key and posy ~= value then
--			windower.ffxi.run(key,value)
--			send command('wait 1;gs c run_to_pos())
--		end
--	end

--	function get_current_pos()
--		local me = windower.ffxi.get_mob_by_name(Deadmau)
--		for key, value in pairs(me) do
--			return value.x, value.y
--		end
--	end

--------------------------------------------------------------------------------
-- Movement Functions
--------------------------------------------------------------------------------
function follow_waypoints(arrayTable)
	local route = arrayTable
	TotalWaypoints = get_key_count(route)
	local currentWaypoint = CurrentWaypoint
	run_direction, x, y = get_running_direction(route[CurrentWaypoint])
	if x < 2 and x > -2 and y < 2 and y > -2 then
		print("You arrived at waypoint")
		CurrentWaypoint = currentWaypoint + 1
		if CurrentWaypoint > TotalWaypoints then
			windower.ffxi.run(false)
			print('you have arrived sir =)')
			CurrentWaypoint = 1
			TotalWaypoints = 0
		else
			follow_waypoints(route)
		end
	else
		windower.ffxi.run(run_direction)
	end
end

-- returns the direction to run based on where you want to go
function get_running_direction(pairofWaypoints)
	local pointx = pairofWaypoints[1]
	local pointy = pairofWaypoints[2]
	print("destination:")
	print(pointx, pointy)
	local currentX, currentY = get_my_position()
	local x = pointx - currentX
	local y = pointy - currentY
	local direction = get_radians(x, y)
	return direction, x, y
end

-- Returns characters current x & y coordinates
function get_my_position()
	local me = windower.ffxi.get_mob_by_name(PlayerName)
	return me.x, me.y
end

-- determines which quadrant the points fall in relative to player and returns radians to add
function get_radians(x, y)
	print("destination - current position")
	print(x, y)
	-- bottom right quad.
	if x > 0 and y < 0 then
		return (-(math.atan(y / x)))
		-- bottom left quad.
	elseif x < 0 and y < 0 then
		return (math.atan(x / y) + math.pi / 2)
		-- top left quad.
	elseif x < 0 and y > 0 then
		return (math.atan(x / y) - (math.pi / 2))
		-- top right quad.
	elseif x > 0 and y > 0 then
		return (-(math.atan(y / x)))
	end
end

--------------------------------------------------------------------------------
-- Idle action Functions
--------------------------------------------------------------------------------

-- Summon Trusts (controls 'FullParty' global)
function summon_trusts()
	local whm, tank, ja1, ja2, ja3 = get_party_list()
	--print(whm, tank, ja1, ja2, ja3)
	if not FullParty then
		-- TODO: add in other possible trusts for these roles, and randomize which one used
		if not whm then
			send_command('Apururu (UC)')
		elseif not tank then
			send_command('Uka Totlihn')
		elseif not ja1 then
			send_command('Mayakov')
		elseif not ja2 then
			send_command('Cherukiki')
		elseif not ja3 then
			send_command('Joachim')
		end
	end
end

function get_party_list()
	local whm, tank, ja1, ja2, ja3 = false, false, false, false, false
	local party = windower.ffxi.get_party()
	for key, value in pairs(party) do
		if key == 'p1' or key == 'p2' or key == 'p3' or key == 'p4' or key == 'p5' then
			for k, v in pairs(value) do
				if k == 'name' then
					-- TODO: add in other possible trusts for these roles
					if v == 'Apururu' then
						--print('Apururu in party')
						whm = true
					elseif v == 'Uka Totlihn' then
						--print('Uka Totlihn in party')
						tank = true
					elseif v == 'Mayakov' then
						--print('Mayakov in party')
						ja1 = true
					elseif v == 'Cherukiki' then
						--print('Cherukiki in party')
						ja2 = true
					elseif v == 'Joachim' then
						--print('Joachim in party')
						ja3 = true
					end
				end
			end
		end
	end
	return whm, tank, ja1, ja2, ja3
end

--------------------------------------------------------------------------------
-- Battle action functions (engaged actions and mob detection)
--------------------------------------------------------------------------------
function has_agro()
	local surroundingMobs = windower.ffxi.get_mob_array()
	for key, mob in pairs(surroundingMobs) do
		if mob.is_npc == true then
			table.vprint(surroundingMobs)
		end
	end
end

function tartet_mobs()
	local surroundingMobs = windower.ffxi.get_mob_array()
	for key, mob in pairs(surroundingMobs) do
	end
end

--------------------------------------------------------------------------------
-- Global variable functions
--------------------------------------------------------------------------------

-- get player index for zone
function get_player_info()
	local player = windower.ffxi.get_player()
	PlayerName = player.name
	PlayerIndex = player.index
	PlayerID = player.id
end

-- determines if party is full, or if need to summon trusts
function get_party_info()
	local party = windower.ffxi.get_party()
	local partyCount = party.party1_count
	if partyCount == 6 then
		FullParty = true
	elseif partyCount ~= 6 then
		FullParty = false
	end
	for i = 0, partyCount - 1 do
		Party[i] = return_party_id('p' .. i)
	end
end

function return_party_id(partyPOS)
	local member = windower.ffxi.get_mob_by_target(partyPOS)
	return member.id
end

-- Created new Random seed for randomized functions
function refresh_random_seed()
	local data = windower.ffxi.get_info()
	local player = windower.ffxi.get_mob_by_id(PlayerID)
	local data2 = windower.ffxi.get_player()
	RandomSeed = (data.day + data.weather + data.moon + data2.vitals.hp + data2.vitals.tp + player.x + math.random(1, 5000)) * data.time
	math.randomseed(RandomSeed)
end

-- Check for time extensions (marks variables as true if time extensions are found in key items list)
function check_for_time_extensions()
	local t = { false, false, false, false, false }
	local keyItems = windower.ffxi.get_key_items()
	for key, val in pairs(keyItems) do

		-- 1545 = crimson (orc)
		if val == 1545 then
			t[1] = true
			print('local t1 = true', t[1])
		end

		-- 1548 = alabastor (goblin)
		if val == 1548 then
			t[2] = true
			print('local t2 = true', t[2])
		end

		-- 1547 = amber (Yagudo)
		if val == 1547 then
			t[3] = true
			print('local t3 = true', t[3])
		end

		-- 1546 = azure (quadav)
		if val == 1546 then
			t[4] = true
			print('local t4 = true', t[4])
		end

		-- 1549 = obsidian (random)
		if val == 1549 then
			t[5] = true
			print('local t5 = true', t[5])
		end
	end
	for key, value in pairs(t) do
		if value == true then
			TE[key] = true
		end
	end
end

--------------------------------------------------------------------------------
-- Helper functions (utility functions, etc.)
--------------------------------------------------------------------------------

-- search a table for a certain value, returns true if found, false if not
function contains_value(table, value)
	local contained = false
	for key, val in pairs(table) do
		if val == value then
			contained = true
		end
	end
	return contained
end

-- iterate over a nested table and return the number of keys
function get_key_count(nestedTable)
	local array = {}
	for key, value in pairs(nestedTable) do
		array[#array + 1] = key
	end
	return #array
end

-- used to Prepare to change camp
-- Intermediate state, checks if invisible, if not it applies it and then waits 5 seconds and calls warp_me()
-- If already invisible, waits 5 seconds and then calls warp_me()
-- Tells maestro to enable special ready_to_warp profile in EZfarm, tako is envoked in next step
function player_invisible()
	if not buffactive['Invisible'] then
		print('*** player not invisble ***')
		send_command('/ja "Spectral Jig" <me>')
		return false
	else
		return true
	end
end

function have_all_TE()
	if TE[1] and TE[2] and TE[3] and TE[4] and TE[5] then
		return true
	else return false
	end
end

-- returns a randomized number between two ranges (basically better version of standard random())
function random_between(v1, v2)
	local x1, x2 = v1 + 1, v2 - 1
	refresh_random_seed()
	math.randomseed(RandomSeed)
	local n1 = math.random(x1, x2)
	local n2 = math.random()
	if math.random(0, 100) % 2 == 0 then
		print(n1 + n2)
	else
		print(n1 - n2)
	end
end


--------------------------------------------------------------------------------
-- Auto-Registering Events (Only initiates the 'start_flow()' fucntion)
--------------------------------------------------------------------------------

-- For entering & exiting Dynamis
windower.register_event('zone change', function(new, old)
	if new == 39 then
		start_flow()
	elseif new == 103 and old == 39 then
		start_flow()
	end
end)

-- 'Engaged', 'Idle', 'Resting', 'Dead', 'Zoning'
windower.register_event('status change', function(new, old)
	if new == 'Engaged' then
		PlayerStatus = 'engaged'
	elseif new == 'Idle' then
		PlayerStatus = 'idle'
	elseif new == 'Resting' then
		print('why are you resting?')
		start_flow()
	elseif new == 'Dead' then
		start_flow()
	elseif new == 'Zoning' then
		start_flow()
	end
end)

-- TODO: add in removal from agroedmob list for when mob status = 3 or 2 maybe? (i think this means defeated), should be able to search by ID or something, try hpp = 0
-- Register and maintain list of agroed mobs based on targets of nearby actions
windower.register_event('action', function(act)
	table.vprint(AgroedMobs)
	if not contains_value(AgroedMobs, act.actor_id) and not contains_value(Party, act.actor_id) then
		for key, value in pairs(act.targets) do
			for k, v in pairs(value) do
				if k == 'id' and contains_value(Party, v) then
					AgroedMobs[#AgroedMobs + 1] = act.actor_id
					table.vprint(AgroedMobs)
					print('target is either you or your party')
				end
			end
		end
	end
end)

--windower.register_event('action', function(act)
--	if act.is_npc == true and not contains_value(Party, act.actor_id) and not contains_value(AgroedMobs, act.actor_id) and act.targets[1].id == PlayerID then
--		AgroedMobs[#AgroedMobs + 1] = act.actor_id
--		table.vprint(AgroedMobs)
--	end
--end)

-- TODO: use this to see if widescan registers, and then if the widscan target is accessable through something.  could be more efficient for time extensions
--windower.register_event('incoming chunk', function(pak)
--	packet = packets.parse(dir, data)
--	table.vprint(packet)
--end)



-- called when file is initially loaded and after functions are defined, which is why its at the end.
controller_refresh_globals()