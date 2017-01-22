TargetName = 'Qilin'
NumOfDisplacers = 3

windower.send_command('lua load vwpop; wait 1; pop d '..NumOfDisplacers..'; wait 1; pop on')



Trust1 = ''
Trust2 = ''
Trust3 = ''
Trust4 = ''
Trust5 = ''


windower.send_command('bind f12 gs c cycle killswitch')

--KillSwitch = false -- Master Kill switch to disable everything

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
Party = {}


function start_flow()
	if state.KillSwitch then
		print('Kill Switch [ON]: stopping all Processes')
	else
		if midaction() then
			print('currently in mid-action, waiting until complete')
		else
			controller_refresh_globals()
			
			-- get current target
			targ = nil
			targ = windower.ffxi.get_mob_by_target('t')
			if (targ == nil) then
				-- not targeting anything, send a tab.
				windower.send_command('setkey tab down; wait 0.2; setkey tab up;')
			elseif (targ.is_npc) then
				if PlayerStatus == 'idle' then
					if (targ.name == TargetName) then
						send_command('/attack <t>')
					--elseif (targ.name == "Planar Rift") then
						
					--elseif (targ.name == "Riftworn Pyxis") then
						
					end
				--elseif PlayerStatus == 'engaged' then
				
				end
			end	
		end
		-- TODO: for production, the wait time should either go away or be extremely low, just set to wait time now to slow things down enough to debug
		windower.send_command('wait 1;gs c startflow')
	end
end

function controller_refresh_globals()
	get_player_info()
	--get_party_info()
	--refresh_random_seed()
	print('--- Globals Refreshed ---')
	print('Player info: ', PlayerName, PlayerIndex, PlayerID)
	--print('FullParty: ', FullParty)
	print('PlayerStatus: ', PlayerStatus)
end

function getTarget(targ)
    if targ == nil then
        return nil
    elseif istable(targ) then
        return targ
    elseif tonumber(targ) and (tonumber(targ) > 255) then
        return windower.ffxi.get_mob_by_id(tonumber(targ))
    elseif S{'<me>','me'}:contains(targ) then
        return windower.ffxi.get_mob_by_target('me')
    elseif (targ == '<t>') then
        return windower.ffxi.get_mob_by_target()
    elseif isstr(targ) then
        local target = windower.ffxi.get_mob_by_name(targ)
        return target or windower.ffxi.get_mob_by_name(targ:ucfirst())
    end
    return nil
end
--------------------------------------------------------------------------------
-- Events
--------------------------------------------------------------------------------

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




--------------------------------------------------------------------------------
-- Summon Trusts (controls 'FullParty' global)
--------------------------------------------------------------------------------

function summon_trusts()
	local whm, tank, ja1, ja2, ja3 = get_party_list()
	--print(whm, tank, ja1, ja2, ja3)
	if not FullParty then
		-- TODO: add in other possible trusts for these roles, and randomize which one used
		if not whm then
			send_command(Trust1)
		elseif not tank then
			send_command(Trust2)
		elseif not ja1 then
			send_command(Trust3)
		elseif not ja2 then
			send_command(Trust4)
		elseif not ja3 then
			send_command(Trust5)
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
					if v == Trust1 then
						--print('Apururu in party')
						whm = true
					elseif v == Trust2 then
						--print('Uka Totlihn in party')
						tank = true
					elseif v == Trust3 then
						--print('Mayakov in party')
						ja1 = true
					elseif v == Trust4 then
						--print('Cherukiki in party')
						ja2 = true
					elseif v == Trust5 then
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

--------------------------------------------------------------------------------
-- Movement Functions
--------------------------------------------------------------------------------
--	function run_to_pos(key, value)
--		local posx, posy = get_current_pos()
--		if posx ~= key and posy ~= value then
--			windower.ffxi.run(key,value)
--			send command('wait 1;gs c run_to_pos())
--		end
--	end

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