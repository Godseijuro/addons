function get_sets()
	sets.Idle = {
		ammo="Ginsen",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+21 Attack+21','"Triple Atk."+3','STR+9','Accuracy+15','Attack+9',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','DEX+9','Accuracy+3',}},
		feet="Skadi's Jambeaux +1",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Infused Earring",
		left_ring="Sheltered Ring",
		right_ring="Paguroidea Ring",
		back="Xucau Mantle",
	}
	-- Regen Set --
	sets.Idle.Regen = set_combine(sets.Idle,{})
	
	-- Movement Set --
	sets.Idle.Movement = set_combine(sets.Idle.Regen,{})

	-- Damage Type Daggers --
	sets.Idle.Regen.Melee = set_combine(sets.Idle.Regen,{})
	
	-- Damage & TH Types Daggers --
	sets.Idle.Regen.TH = set_combine(sets.Idle.Regen,{})
-- todo:fixed equipment change for reives down below, move equipment sets up here as a variable set type? also fix in else if down below for oneiros ring if MP is above 100--

	-- Damage Type Daggers --
	sets.Idle.Movement.Melee = set_combine(sets.Idle.Movement,{})
	
	-- Damage & TH Types Daggers --
	sets.Idle.Movement.TH = set_combine(sets.Idle.Movement,{})

	-- Normal TP Sets --
	sets.TP = {
		ammo="Ginsen",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+21 Attack+21','"Triple Atk."+3','STR+9','Accuracy+15','Attack+9',}},
		legs="Samnuha Tights",
		feet={ name="Rawhide Boots", augments={'HP+50','Accuracy+15','Evasion+20',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Dudgeon Earring",
		right_ear="Heartseeker Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Canny Cape", augments={'DEX+4','AGI+1','"Dual Wield"+5',}},
	}
			
    -- Mid-Accuracy --
	sets.TP.MidACC = set_combine(sets.TP,{})
	
	-- High-Accuracy --
	sets.TP.HighACC = set_combine(sets.TP.MidACC,{})

	-- March x2 + (Haste or Samba) --
	-- March + Haste + Samba --
	-- (Embrava or Geo Haste) + (March or Haste or Samba) --
	sets.TP.MidHaste = set_combine(sets.TP,{})
	sets.TP.MidACC.MidHaste = set_combine(sets.TP.MidHaste,{})
	sets.TP.HighACC.MidHaste = set_combine(sets.TP.MidACC.MidHaste,{})

	-- March x2 + Haste + Samba --
	-- Embrava + (March or Haste) + Samba --
	-- Geo Haste + (March or Haste or Embrava) + Samba --
	sets.TP.HighHaste = set_combine(sets.TP.MidHaste,{})
	sets.TP.MidACC.HighHaste = set_combine(sets.TP.HighHaste,{})
	sets.TP.HighACC.HighHaste = set_combine(sets.TP.MidACC.HighHaste,{})

	-- Full TH TP Set --
	sets.TP.TH = set_combine(sets.TP, TH_Gear)

	-- TP Rancor ON Neck --
	sets.TP.Rancor = {}

	-- TP Feint Set --
	sets.TP.Feint = {}

	-- PDT/MDT Sets --
	sets.PDT = {}

	sets.MDT = set_combine(sets.PDT,{})

	-- Hybrid/Evasion Sets --
	sets.TP.Hybrid = set_combine(sets.PDT,{})
	sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{})
	sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{})

	sets.Evasion = set_combine(sets.PDT,{})

	-- WS Base Set --
	sets.WS = {}

	-- WS Sets --
	sets.WS["Mercy Stroke"] = {}
	sets.WS["Mercy Stroke"].SA = {hands="Skulk. Armlets +1"}
	sets.WS["Mercy Stroke"].TA = {hands="Pill. Armlets +1"}

	sets.WS.Exenterator = {}
	sets.WS.Exenterator.SA = set_combine(sets.WS.Exenterator,{})
	sets.WS.Exenterator.TA = set_combine(sets.WS.Exenterator,{})

	sets.WS.Evisceration = {}
	sets.WS.Evisceration.SA = set_combine(sets.WS.Evisceration,{})
	sets.WS.Evisceration.TA = set_combine(sets.WS.Evisceration,{})

	sets.WS["Rudra's Storm"] = {}
	sets.WS["Rudra's Storm"].SA = set_combine(sets.WS["Rudra's Storm"],{})
	sets.WS["Rudra's Storm"].TA = set_combine(sets.WS["Rudra's Storm"],{})

	sets.WS["Aeolian Edge"] = {}
	
	sets.WS["Mandalic Stab"] = {}

	-- JA Sets --
	sets.JA = {}
	TH_Gear = {hands="Plunderer's Armlets +1", feet="Skulker's Poulaines +1", waist="Chaac Belt"}
	sets.JA.Conspirator = {body="Skulker's Vest +1"}
	sets.JA.Accomplice = {head="Skulker's Bonnet +1"}
	sets.JA.Collaborator = {head="Skulker's Bonnet +1"}
	sets.JA["Perfect Dodge"] = {hands="Plun. Armlets +1"}
	sets.JA.Steal = {hands="Pill. Armlets +1",legs="Pill. Culottes +1",feet="Pill. Poulaines +1"}
	sets.JA.Flee = {}
	sets.JA.Despoil = {}
	sets.JA.Mug = {head="Plun. Bonnet +1"}
	sets.JA.Hide = {body="Pillager's Vest +1"}
	sets.JA.Provoke = TH_Gear
	sets.JA["Sneak Attack"] = {}
	sets.JA["Trick Attack"] = set_combine(sets.JA["Sneak Attack"],{})

	-- Step Set --
	sets.Step = set_combine({right_ear="Choreia Earring"},TH_Gear)

	-- Flourish Set --
	sets.Flourish = set_combine({},TH_Gear)

	-- Waltz Set --
	sets.Waltz = {}

	sets.Precast = {}
	-- Fastcast Set --
	sets.Precast.FastCast = {}
	
	-- Utsusemi Precast Set --
	sets.Precast.Utsusemi = set_combine(sets.Precast.FastCast,{neck="Magoraga Beads"})

	sets.Midcast = {}
	-- Magic Haste Set --
	sets.Midcast.Haste = set_combine(sets.PDT,{})
	
	-- Ranged Attack Set --
	sets.RA = {}
	
	-- Organizer Items --
	organizer_items = {}
	
	
	
	
	
	-- Include the Dynamis Bot lua --
	include('_dynabot.lua')
	-- Array to hold the recorded waypoint locations --
	locs = {}
	
	-- Thief Variables
	AccIndex = 1
	AccArray = { "Normal", "MidACC", "HighACC" } -- 3 Levels Of Accuracy Sets For TP/Hybrid. Default ACC Set Is LowACC. The First TP Set Of Your Main Weapon Is LowACC. Add More ACC Sets If Needed Then Create Your New ACC Below --
	WeaponIndex = 1
	WeaponArray = { "Melee", "TH" } -- Default Sub Weapon Is Melee. Don't Input Main/Sub In TP Sets. Melee = Damage Type Dagger | TH = TH Type Dagger --
	IdleIndex = 1
	IdleArray = { "Movement", "Regen" } -- Default Idle Set Is Movement --
	SA = false
	TA = false
	TH = 'ON' -- Set Default Full TH ON or OFF Here --
	target_distance = 4 -- Set Default Distance Here --
	--select_default_macro_book() -- Change Default Macro Book At The End --

	-- Load treasury to drop all '-1' items & crap
	--send_command('lua l treasury')
end

--------------------------------------------------------------------------------
-- Pretarget
--------------------------------------------------------------------------------
function pretarget(spell, action)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
	cancel_spell()
	send_command('input /item "Echo Drops" <me>')
	elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
	cancel_spell()
	send_command('Aggressor')
	elseif spell.action_type == 'Ranged Attack' and spell.target.distance > 24.9 then
		cancel_spell()
		print(166, spell.name .. ' Canceled: [Out of Range]')
		return
		--elseif spell.type == "WeaponSkill" and spell.target.distance > target_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
		--	cancel_spell()
		--	print(166, spell.name..' Canceled: [Out of Range]')
		--	return
	end
end

--------------------------------------------------------------------------------
-- Precast
--------------------------------------------------------------------------------
function precast(spell, action)
	if spell.type == "WeaponSkill" then
		if player.status ~= 'Engaged' then -- Cancel WS If You Are Not Engaged. Can Delete It If You Don't Need It --
		cancel_spell()
		print(166, 'Unable To Use WeaponSkill: [Disengaged]')
		return
		else
			equipSet = sets.WS
			if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
			end
			if SA and equipSet["SA"] then
				equipSet = equipSet["SA"]
			end
			if TA and equipSet["TA"] then
				equipSet = equipSet["TA"]
			end
			if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
			equipSet = set_combine(equipSet, { neck = "Ygnas's Resolve +1" })
			end
			if spell.english == "Evisceration" and player.tp > 2990 then -- Equip Jupiter's Pearl When You Have 3000 TP --
			equipSet = set_combine(equipSet, { ear1 = "Jupiter's Pearl" })
			end
			equip(equipSet)
		end
	elseif spell.type == "JobAbility" then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
		if spell.english == "Sneak Attack" then
			SA = true
		end
		if spell.english == "Trick Attack" then
			TA = true
		end
	elseif spell.action_type == 'Magic' then
		if spell.english:startswith('Utsusemi') then
			if spell.english == 'Utsusemi: Ni' then
				if buffactive['Copy Image (3)'] then
					cancel_spell()
					print(166, spell.name .. ' Canceled: [3 Images]')
					return
				else
					equip(sets.Precast.Utsusemi)
				end
			else
				equip(sets.Precast.Utsusemi)
			end
		else
			equip(sets.Precast.FastCast)
		end
	elseif spell.type == 'Step' then
		equip(sets.Step)
	elseif spell.type:endswith('Flourish') then
		equip(sets.Flourish)
	elseif spell.type == "Waltz" then
		refine_waltz(spell, action)
		equip(sets.Waltz)
	elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
		cast_delay(0.2)
		send_command('cancel Sneak')
	end
end

--------------------------------------------------------------------------------
-- Midcast
--------------------------------------------------------------------------------
function midcast(spell, action)
	if spell.action_type == 'Ranged Attack' then
		equip(sets.RA)
	elseif spell.action_type == 'Magic' then
		if spell.english:startswith('Utsusemi') then
			if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then
				send_command('@wait 1.7;cancel Copy Image*')
			end
			equip(sets.Midcast.Haste)
		elseif spell.english == 'Monomi: Ichi' then
			if buffactive['Sneak'] then
				send_command('@wait 1.7;cancel sneak')
			end
			equip(sets.Midcast.Haste)
		else
			equip(sets.Midcast.Haste)
		end
	end
end

--------------------------------------------------------------------------------
-- Aftercast
--------------------------------------------------------------------------------
function aftercast(spell, action)
	if spell.type == "WeaponSkill" and not spell.interrupted then
		send_command('wait 0.2;gs c TP')
	end
	status_change(player.status)
end

--------------------------------------------------------------------------------
-- Status Change
--------------------------------------------------------------------------------
function status_change(new, old)
	check_equip_lock()
	if Armor == 'PDT' then
		equip(sets.PDT)
	elseif Armor == 'MDT' then
		equip(sets.MDT)
	elseif Armor == 'EVA' then
		equip(sets.Evasion)

		-- Engaged
	elseif new == 'Engaged' then
		equipSet = sets.TP
		if Armor == 'Hybrid' and equipSet["Hybrid"] then
			equipSet = equipSet["Hybrid"]
		end
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
		if (buffactive.Embrava and (buffactive.March or buffactive.Haste) and buffactive['Haste Samba']) or (buffactive.March == 2 and buffactive.Haste and buffactive['Haste Samba']) or (buffactive[580] and (buffactive.March or buffactive.Haste or buffactive.Embrava) and buffactive['Haste Samba']) and equipSet["HighHaste"] then
			equipSet = equipSet["HighHaste"]
		end
		if ((buffactive.Embrava or buffactive[580]) and (buffactive.March or buffactive.Haste or buffactive['Haste Samba'])) or (buffactive.March == 1 and buffactive.Haste and buffactive['Haste Samba']) or (buffactive.March == 2 and (buffactive.Haste or buffactive['Haste Samba'])) and equipSet["MidHaste"] then
			equipSet = equipSet["MidHaste"]
		end
		if SA then
			equipSet = set_combine(equipSet, sets.JA["Sneak Attack"])
		end
		if TA then
			equipSet = set_combine(equipSet, sets.JA["Trick Attack"])
		end
		if buffactive.Feint then
			equipSet = set_combine(equipSet, sets.TP.Feint)
		end
		if TH == 'ON' then -- Use TH Toggle To Lock Full TH Set --
		equipSet = set_combine(equipSet, sets.TP.TH)
		end
		equip(equipSet)

		-- Idle
	elseif new == 'Idle' then
		equipSet = sets.Idle
		if equipSet[IdleArray[IdleIndex]] then
			equipSet = equipSet[IdleArray[IdleIndex]]
		end
		if equipSet[WeaponArray[WeaponIndex]] then
			equipSet = equipSet[WeaponArray[WeaponIndex]]
		end
		if buffactive['Reive Mark'] then -- Equip Homestead Dagger & Ygnas's Resolve +1 During Reive --
		equipSet = set_combine(equipSet, { sub = "Homestead Dagger", neck = "Ygnas's Resolve +1" })
		end
		if world.area:endswith('Adoulin') then
			equipSet = set_combine(equipSet, { body = "Councilor's Garb" })
		end
		if Warp == "ON" then
			equipSet = set_combine(equipSet, { ring1 = "Warp Ring" })
		end
		equip(equipSet)
	end
end

--------------------------------------------------------------------------------
-- Buff Change
--------------------------------------------------------------------------------
function buff_change(buff, gain)
	-- TODO: prioritize dynamis farming actions here, add in trust check before ChangeCamp to see re-summon trusts if need be?
	if ChangeCamp then
		--get_ready_to_change_camps()
	end

	buff = string.lower(buff)
	if buff == "sneak attack" then
		SA = gain
	elseif buff == "trick attack" then
		TA = gain
	elseif buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
	if gain then
		send_command('timers create "Aftermath: Lv.3" 180 down;wait 150;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 15;input /echo Aftermath: Lv.3 [WEARING OFF IN 15 SEC.];wait 5;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
	else
		send_command('timers delete "Aftermath: Lv.3"')
		print(166, 'AM3: [OFF]')
	end
	elseif buff == 'weakness' then -- Weakness Timer --
	if gain then
		send_command('timers create "Weakness" 300 up')
	else
		send_command('timers delete "Weakness"')
	end
	end
	if not midaction() then
		status_change(player.status)
	end
end


--------------------------------------------------------------------------------
-- Helper Functions
--------------------------------------------------------------------------------
function check_equip_lock() -- Lock Equipment Here --
if player.equipment.range ~= 'empty' then
	disable('range', 'ammo')
elseif player.equipment.left_ring == "Warp Ring" or player.equipment.left_ring == "Capacity Ring" or player.equipment.right_ring == "Warp Ring" or player.equipment.right_ring == "Capacity Ring" then
	disable('ring1', 'ring2')
elseif player.equipment.back == "Mecisto. Mantle" or player.equipment.back == "Aptitude Mantle +1" or player.equipment.back == "Aptitude Mantle" then
	disable('back')
else
	enable('range', 'ammo', 'ring1', 'ring2', 'back')
end
end

function refine_waltz(spell, action)
	if spell.type ~= 'Waltz' then
		return
	end

	if spell.name == "Healing Waltz" or spell.name == "Divine Waltz" or spell.name == "Divine Waltz II" then
		return
	end

	local newWaltz = spell.english
	local waltzID

	local missingHP

	if spell.target.type == "SELF" then
		missingHP = player.max_hp - player.hp
	elseif spell.target.isallymember then
		local target = find_player_in_alliance(spell.target.name)
		local est_max_hp = target.hp / (target.hpp / 100)
		missingHP = math.floor(est_max_hp - target.hp)
	end

	if missingHP ~= nil then
		if player.sub_job == 'DNC' then
			if missingHP < 40 and spell.target.name == player.name then
				print(166, 'Full HP!')
				cancel_spell()
				return
			elseif missingHP < 150 then
				newWaltz = 'Curing Waltz'
				waltzID = 190
			elseif missingHP < 300 then
				newWaltz = 'Curing Waltz II'
				waltzID = 191
			else
				newWaltz = 'Curing Waltz III'
				waltzID = 192
			end
		else
			return
		end
	end

	local waltzTPCost = { ['Curing Waltz'] = 20, ['Curing Waltz II'] = 35, ['Curing Waltz III'] = 50 }
	local tpCost = waltzTPCost[newWaltz]

	local downgrade

	if player.tp < tpCost and not buffactive.trance then

		if player.tp < 20 then
			print(166, 'Insufficient TP [' .. tostring(player.tp) .. ']. Cancelling.')
			cancel_spell()
			return
		elseif player.tp < 35 then
			newWaltz = 'Curing Waltz'
		elseif player.tp < 50 then
			newWaltz = 'Curing Waltz II'
		end

		downgrade = 'Insufficient TP [' .. tostring(player.tp) .. ']. Downgrading to ' .. newWaltz .. '.'
	end

	if newWaltz ~= spell.english then
		send_command('@input /ja "' .. newWaltz .. '" ' .. tostring(spell.target.raw))
		if downgrade then
			print(212, downgrade)
		end
		cancel_spell()
		return
	end

	if missingHP > 0 then
		print(212, 'Trying to cure ' .. tostring(missingHP) .. ' HP using ' .. newWaltz .. '.')
	end
end

function find_player_in_alliance(name)
	for i, v in ipairs(alliance) do
		for k, p in ipairs(v) do
			if p.name == name then
				return p
			end
		end
	end
end

function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end

function set_macro_page(set, book)
	if not tonumber(set) then
		print(166, 'Error setting macro page: Set is not a valid number (' .. tostring(set) .. ').')
		return
	end
	if set < 1 or set > 10 then
		print(166, 'Error setting macro page: Macro set (' .. tostring(set) .. ') must be between 1 and 10.')
		return
	end

	if book then
		if not tonumber(book) then
			print(166, 'Error setting macro page: book is not a valid number (' .. tostring(book) .. ').')
			return
		end
		if book < 1 or book > 20 then
			print(166, 'Error setting macro page: Macro book (' .. tostring(book) .. ') must be between 1 and 20.')
			return
		end
		send_command('@input /macro book ' .. tostring(book) .. ';wait .1;input /macro set ' .. tostring(set))
	else
		send_command('@input /macro set ' .. tostring(set))
	end
end

function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(4, 4)
	elseif player.sub_job == 'DNC' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 4)
	else
		set_macro_page(1, 4)
	end
end

--------------------------------------------------------------------------------
-- //gs c (command), Macro: /console gs c (command), Bind: gs c (command)
--------------------------------------------------------------------------------
function self_command(command)

	-- Accuracy Level Toggle
	if command == 'C1' then
		AccIndex = (AccIndex % #AccArray) + 1
		status_change(player.status)
		print(212, 'Accuracy Level: ' .. AccArray[AccIndex])

		-- Sub Weapon Type Toggle
	elseif command == 'C17' then
		WeaponIndex = (WeaponIndex % #WeaponArray) + 1
		print(212, 'Sub Weapon Type: ' .. WeaponArray[WeaponIndex])
		status_change(player.status)

		-- Auto Update Gear Toggle
	elseif command == 'C5' then
		status_change(player.status)
		print(212, 'Auto Update Gear')

		-- Full TH Set Toggle
	elseif command == 'th' then
		if TH == 'ON' then
			TH = 'OFF'
			print('Full TH Set: [Unlocked]')
		else
			TH = 'ON'
			print('Full TH Set: [Locked]')
		end
		status_change(player.status)

		-- PDT Toggle
	elseif command == 'C7' then
		if Armor == 'PDT' then
			Armor = 'None'
			print(166, 'PDT Set: [Unlocked]')
		else
			Armor = 'PDT'
			print(212, 'PDT Set: [Locked]')
		end
		status_change(player.status)

		-- Distance Toggle
	elseif command == 'C8' then
		if player.target.distance then
			target_distance = math.floor(player.target.distance * 10) / 10
			print(212, 'Distance: ' .. target_distance)
		else
			print(166, 'No Target Selected')
		end

		-- Idle Toggle
	elseif command == 'C6' then
		IdleIndex = (IdleIndex % #IdleArray) + 1
		status_change(player.status)
		print(212, 'Idle Set: ' .. IdleArray[IdleIndex])

		-- TP Command
	elseif command == 'TP' then
		print(212, 'TP Return: [' .. tostring(player.tp) .. ']')

		-- Other Commands
	elseif command:match('^SC%d$') then
		send_command('//' .. sc_map[command])
	end

	--------------------------------------------------------------------------------
	-- Dyna-B commands
	--------------------------------------------------------------------------------

	-- KillSwitch toggle
	if command == 'killswitch' then
		if KillSwitch == true then
			KillSwitch = false
			print('KillSwitch: [Off]')
		else
			KillSwitch = true
			print('KillSwitch: [On]')
			start_flow()
		end
	end
	-- possibly best place for "middleware" or other things to monitor
	if KillSwitch == false then
		-- ChangeCamp Toggle
		if command == 'ChangeCamp' then
			ChangeCamp = true

			-- Call Function determine_camp√()
		elseif command == 'followwaypoints' then
			follow_waypoints(Route[5])

			-- test 1
		elseif command == 'test1' then
			windower.copy_to_clipboard('Command from gearswap!!! =)')
			print('KillSwitch = ' .. tostring(ChangeCamp) .. '')
			print('ChangeCamp = ' .. tostring(ChangeCamp) .. '')
			print('MovingCamp = ' .. tostring(ChangeCamp) .. '')
			print('TE1 = ' .. tostring(TE[1]) .. '')
			print('TE2 = ' .. tostring(TE[2]) .. '')
			print('TE3 = ' .. tostring(TE[3]) .. '')
			print('TE4 = ' .. tostring(TE[4]) .. '')
			print('TE5 = ' .. tostring(TE[5]) .. '')
			print('GameTime = ' .. world.time .. '')
			print('TestPos = ' .. TestPosition .. '')
			table.vprint(Route[5])

		elseif command == 'startflow' then
			start_flow()

		elseif command == 'globals' then
			controller_refresh_globals()

			-- test 3
		elseif command == 'test3' then
			local count = get_key_count(RouteTE5)
			print(count)

			-- test 5
		elseif command == 'test5' then
			local mob = windower.ffxi.get_mob_by_target('r')
			for key, value in pairs(mob) do print(key, value) end

			-- test 6
		elseif command == 'test6' then
			local mobs = windower.ffxi.get_mob_array()
			for key, value in pairs(mobs) do
				--if not value.is_npc then
				if value.name == 'Deadmau' then
					print('-------------------')
					print(value.name)
					print(value.id)
					--print(value.race)
					print(value.distance)
					--print(value.is_npc)
					print(value.entity_type)
				end
			end
		elseif command == 'test8' then
			local mobs = windower.ffxi.get_mob_array()
			--for i = 1, 5,
			for key, value in pairs(mobs) do
				-- can determine other PCs by if race is > 0 and if is_npc is false
				if value.race > 0 and not value.is_npc then
					send_command('gs add_to_blacklist ' .. value.id .. '')
				else
					print('already on the list')
				end
			end

		elseif command == 'test9' then
			check_for_time_extensions()

			-- Test Position - toggles autorecordpos to loop printing your position to the console
		elseif command == 'makemap' then
			if TestPosition == 'ON' then
				TestPosition = 'OFF'
				print('TestPosition: [Off]')
				
				-- export the stored locations to file.
				if not windower.dir_exists(windower.addon_path..'data/export') then
					windower.create_dir(windower.addon_path..'data/export')
				end
				
				local path = windower.addon_path..'data/export/dynabot'
				path = path..os.date(' %Y-%m-%d %H-%M-%S')
				
				if (not overwrite_existing) and windower.file_exists(path..'.lua') then
					path = path..' '..os.clock()
				end
				local f = io.open(path..'.lua','w+')
				
				f:write('Route = {\n')
				for i, loc in ipairs(locs) do
					f:write('    { '..loc..' },\n')
				end
				f:write('}')
				f:close()
				print('Exported to: '..path)
				
				-- clear array
				locs = {}
			else
				TestPosition = 'ON'
				print('TestPosition: [On]')
				send_command('input //gs c mrecord')
			end
			status_change(player.status)

			-- Loops printing your position to the console
		elseif command == 'mrecord' then
			if TestPosition == 'ON' then
				local player = windower.ffxi.get_mob_by_id(PlayerID)
				print(player.x, player.y)
				-- store the location in array
				table.insert(locs, player.x..', '..player.y)
				send_command('wait 3;input //gs c mrecord')
			end

			-- Moving Camp test
		elseif command == 'loop_movetonewcamp' then
			determine_camp()

		elseif command == 'targetnpc' then
			send_command('setkey f8;setkey f8 up')

		elseif command == 'getTE' then
			get_closest_TE(5)

		elseif command == 'getpartyinfo' then
			local mob = windower.ffxi.get_mob_by_target('p1')
			table.vprint(mob)

		elseif command == 'gettargetinfo' then
			local mob = windower.ffxi.get_mob_by_target('t')
			table.vprint(mob)
			--for key, value in pairs(mob) do
			--	print(key, value)
			--	if key == 'id' then
			--		targetMob1 = value
			--	end
			--	send_command('wait 2;gs c printid;wait 3;gs c printid;wait 3;gs c printid;wait 3;gs c printid;wait 3;gs c printid;wait 3;gs c printid')
			--end
			--local mob = windower.ffxi.get_mob_by_id(key)
			--print(key)
			--for key, value in pairs(mob) do print(key, value) end

			-- test 8 - adding to blacklist

		elseif command == 'printid' then
			table.vprint(windower.ffxi.get_mob_by_id(targetMob1))
		elseif command == 'randomseed' then
			refresh_random_seed()
		elseif command == 'random' then
			random_between(20, 50)
		end
	else
		print('KillSwitch ON: Canceling all actions')
	end
end