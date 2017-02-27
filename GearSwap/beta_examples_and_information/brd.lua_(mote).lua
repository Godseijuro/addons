-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end

	send_command('unbind ^`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	-- Default macro set/book
	set_macro_page(9, 12)
	
	-- Additional local binds
	send_command('bind ^` input /ma "Chocobo Mazurka" <me>')

	
	-- Options: Override default values
	options.CastingModes = {'Normal', 'Resistant'}
	options.OffenseModes = {'None', 'Normal'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	state.OffenseMode = 'None'
	
	
	state.Buff['Pianissimo'] = buffactive['pianissimo'] or false
	
	-- For tracking current recast timers via the Timers plugin.
	timer_reg = {}

	-- Some vars.  Define at the top so that the sets can make use of them.
	DaurdSongs = S{'Water Carol','Warding Round','Gold Capriccio','Fowl Aubade',
	               'Shining Fantasia','Herb Pastoral','Goblin Gavotte','Chocobo Mazurka',
				   
				   }

	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main="Apamajas I",sub="Vivid Strap",
		head="Nahtirah Hat",ear2="Loquac. Earring",body="Anhur Robe",
		hands="Gendewitha Gages",ring1="Prolix Ring",neck="Orunmila's Torque",
		back="Swith Cape",waist="Witful Belt",legs="Orvail Pants",feet="Chelona Boots"}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris",back="Pahtli Cape"})

	sets.precast.FC.EnhancingMagic = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.BardSong = {main="Felibre's Dague",range="Gjallarhorn",
		head="Aoidos' Calot +2",neck="Orunmila's Torque",ear1="Aoidos' Earring",ear2="Loquac. Earring",
		body="Sha'ir Manteel",hands="Gendewitha Gages",ring1="Prolix Ring",ring2="Veneficium Ring",
		back="Swith Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Bihu Slippers +1"}
	
	sets.precast.FC.March = {main="Apamajas I",sub="Vivid Strap",range="Gjallarhorn",
		head="Aoidos' Calot +2",neck="Orunmila's Torque",ear1="Aoidos' Earring",ear2="Loquac. Earring",
		body="Sha'ir Manteel",hands="Gendewitha Gages",ring1="Prolix Ring",ring2="Veneficium Ring",
		back="Swith Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Bihu Slippers +1"}	
		
	sets.precast.FC.Prelude = {main="Apamajas I",sub="Vivid Strap",range="Gjallarhorn",
		head="Aoidos' Calot +2",neck="Orunmila's Torque",ear1="Aoidos' Earring",ear2="Loquac. Earring",
		body="Sha'ir Manteel",hands="Gendewitha Gages",ring1="Prolix Ring",ring2="Veneficium Ring",
		back="Swith Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Bihu Slippers +1"}		
		
	sets.precast.FC.Madrigal = {main="Apamajas I",sub="Vivid Strap",range="Gjallarhorn",
		head="Aoidos' Calot +2",neck="Orunmila's Torque",ear1="Aoidos' Earring",ear2="Loquac. Earring",
		body="Sha'ir Manteel",hands="Gendewitha Gages",ring1="Prolix Ring",ring2="Veneficium Ring",
		back="Swith Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Bihu Slippers +1"}	
		
	sets.precast.FC["Herb Pastoral"] = {main="Apamajas I",sub="Vivid Strap",
		head="Aoidos' Calot +2",neck="Orunmila's Torque",ear1="Aoidos' Earring",ear2="Loquac. Earring",
		body="Sha'ir Manteel",hands="Gendewitha Gages",ring1="Prolix Ring",ring2="Veneficium Ring",
		back="Swith Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Bihu Slippers +1"}
	
	sets.precast.FC["Water Carol"] = {main="Apamajas I",sub="Vivid Strap",
		head="Aoidos' Calot +2",neck="Orunmila's Torque",ear1="Aoidos' Earring",ear2="Loquac. Earring",
		body="Sha'ir Manteel",hands="Gendewitha Gages",ring1="Prolix Ring",ring2="Veneficium Ring",
		back="Swith Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Bihu Slippers +1"}
		
	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range="Daurdabla"})
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	sets.precast.JA.Troubadour = {body="Bihu Justaucorps"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {range="Gjallarhorn",
		head="Nahtirah Hat",
		body="Gendewitha Bliaut",hands="Buremte Gloves",
		back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {range="Gjallarhorn",
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Bard's Justaucorps +2",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Brioso Justaucorps +1",hands="Bihu Cuffs +1",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Phos Belt",legs="Bihu Cannions +1",feet="Gendewitha Galoshes +1"}

	sets.precast.WS['Exenterator'] = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Brioso Justaucorps +1",hands="Bihu Cuffs +1",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Phos Belt",legs="Bihu Cannions +1",feet="Gendewitha Galoshes +1"}

	sets.precast.WS['Mordant Rime'] = {range="Gjallarhorn",
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Bard's Justaucorps +2",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	
	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {range="Angel Lyre",
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Brioso Just. +1",hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",waist="Phos Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
		
	-- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
	sets.midcast.Ballad = {legs="Aoidos' Rhing. +2"}
	sets.midcast.Lullaby = {hands="Brioso Cuffs"}
	sets.midcast.Madrigal = {head="Aoidos' Calot +2"}
	sets.midcast.March = {hands="Aoidos' Manchettes +2"}
	sets.midcast.Minuet = {body="Aoidos' Hongreline +2"}
	sets.midcast.Minne = {}
	sets.midcast.Paeon = {head="Brioso Roundlet +1"}
	sets.midcast.Carol = {}
	sets.midcast["Sentinel's Scherzo"] = {legs="Mdk. Shalwar +1",feet="Aoidos' Cothrn. +2"}
	sets.midcast['Magic Finale'] = {}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {main="Legato Dagger",sub="Slime Shield",range="Gjallarhorn",
		head="Aoidos' Calot +2",neck="Aoidos' Matinee",ear2="Loquacious Earring",
		body="Aoidos' Hongreline +2",hands="Aoidos' Manchettes +2",ring1="Prolix Ring",
		back="Rhapsode's Cape",waist="Corvax Sash",legs="Aoidos' Rhing. +2",feet="Aoidos' Cothrn. +2"}

	-- For song defbuffs
	sets.midcast.SongDebuff = {
		main="Twebuliij",
		sub="Mephitis Grip",
		range="Gjallarhorn",
		head="Brioso Roundlet +1",
		body="Brioso Just. +1",
		hands="Bihu Cuffs +1",
		legs="Bihu Cannions +1",
		feet="Artsieq Boots",
		neck="Piper's Torque",
		waist="Demonry Sash",
		ear1="Psystorm Earring",
		ear2="Lifestorm Earring",
		ring1="Sangoma Ring",
		ring2="Maquette Ring",
		back="Rhapsode's Cape",
		}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {ear2="Loquacious Earring",
		ring1="Prolix Ring",
		back="Harmony Cape",waist="Corvax Sash",legs="Aoidos' Rhing. +2"}

	sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range="Daurdabla"})

	-- Other general spells and classes.
	sets.midcast.Cure = {main="Chatoyant Staff",sub='Achaq Grip',
		head="Gendewitha Caubeen",neck="Phalaina Locket",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Aquasoul Ring",ring2="Sirona's Ring",
		back="Refraction Cape",waist="Cascade belt",legs="Mdk. Shalwar +1",feet="Rubeus Boots"}
		
	sets.midcast.Stoneskin = {
		head="Nahtirah Hat",neck="Colossus's Torque",ear1="Aredan Earring",ear2="Earthcry Earring",
		body="Brioso Justaucorps +1",hands="Bihu Cuffs +1",ring1="Aquasoul Ring",ring2="Aquasoul Ring",
		back="Merciful Cape",waist="Cascade Belt",legs="Bihu Cannions +1",feet="Rubeus boots"}
		
	sets.midcast.Cursna = {
		neck="Malison Medallion",
		hands="Hieros Mittens",
		feet="Gende. Galosh. +1",
		ring1="Ephedra Ring",
		}
		
	sets.midcast.Silence = {main="Twebuliij",sub="Mephitis Grip",range="Gjallarhorn",
		head="Brioso Roundlet +1",neck="Orunmila's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Brioso Just. +1",hands="Bihu Cuffs +1",ring1="Sangoma Ring",ring2="Maquette Ring",
		back="Rhapsode's Cape",waist="demonry sash",legs="Bihu Cannions +1",feet="Artsieq Boots"}
		
	sets.midcast.Slow = {main="Twebuliij",sub="Mephitis Grip",range="Gjallarhorn",
		head="Brioso Roundlet +1",neck="Orunmila's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Brioso Just. +1",hands="Bihu Cuffs +1",ring1="Sangoma Ring",ring2="Maquette Ring",
		back="Rhapsode's Cape",waist="demonry sash",legs="Bihu Cannions +1",feet="Artsieq Boots"}
		
		sets.midcast.Paralyze = {main="Twebuliij",sub="Mephitis Grip",range="Gjallarhorn",
		head="Brioso Roundlet +1",neck="Orunmila's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Brioso Just. +1",hands="Bihu Cuffs +1",ring1="Sangoma Ring",ring2="Maquette Ring",
		back="Rhapsode's Cape",waist="demonry sash",legs="Bihu Cannions +1",feet="Artsieq Boots"}
		
		sets.midcast.Stone = {main="Twebuliij",sub="Mephitis Grip",range="Gjallarhorn",
		head="Nahtirah Hat",neck="Twilight Torque",ear1='lifestorm earring',ear2='psystorm earring',
		body="Bihu Justaucorps",hands="Gendewitha Gages",ring1='Dark Ring',ring2='dark ring',
		back="Rhapsode's Cape",waist="demonry sash",legs="Gendewitha Spats",feet="Brioso Slippers"}
		
		sets.midcast.Stun = {main="Plenitas Virga",
		sub="Vivid Strap",
		head="Nahtirah Hat",
		body="Hedera Cotehardie",
		hands="Gendewitha Gages",
		legs="Bihu Cannions +1",
		feet="Gende. Galosh. +1",
		neck="Orunmila's Torque",
		waist="Witful Belt",
		ear2="Loquac. Earring",
		ring1="Prolix Ring",
		ring2="Veneficium ring",
		back="Swith Cape",
		}
		
		

		
		
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main=gear.Staff.HMP, 
		body="Gendewitha Bliaut",
		legs="Nares Trews",feet="Chelona Boots +1"}
	
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Terra's Staff", sub="Oneiros Grip",range="Oneiros Harp",
		head="Wivre Hairpin",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Bihu Justaucorps",hands="Serpentes Cuffs",ring1="Paguroidea Ring",ring2="Sangoma Ring",
		back="Shadow mantle",waist="Fucho-no-obi",legs="Stearc Subligar",feet="Aoidos' Cothurnes +2"}

	sets.idle.Town = {main="Twebuliij", sub="Oneiros Grip",range="Oneiros Harp",
		head="Wivre Hairpin",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Bihu Justaucorps",hands="Serpentes Cuffs",ring1="Paguroidea Ring",ring2="Sangoma Ring",
		back="Shadow mantle",waist="Fucho-no-obi",legs="Stearc Subligar",feet="Aoidos' Cothurnes +2"}
	
	sets.idle.Weak = {main="Plenitas Virga", sub="Oneiros Grip",range="Oneiros Harp",
		head="Wivre Hairpin",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Bihu Justaucorps",hands="Serpentes Cuffs",ring1="Paguroidea Ring",ring2="Sangoma Ring",
		back="Shadow mantle",waist="Fucho-no-obi",legs="Stearc Subligar",feet="Aoidos' Cothurnes +2"}
	
	
	-- Defense sets

	sets.defense.PDT = {main="Terra's Staff",sub="Oneiros Grip",
		head="Gendewitha Caubeen",neck="Twilight Torque",
		body="Bihu Justaucorps",hands="Bihu Cuffs +1",ring1='Dark Ring',ring2='dark ring',
		back="Shadow Mantle",waist="Fucho-no-obi",legs="Bihu Cannions +1",feet="Gende. Galosh. +1"}

	sets.defense.MDT = {main=gear.Staff.PDT,sub="Quire Grip",
		head="Nahtirah Hat",neck="Twilight Torque",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1='Dark Ring',--[[ring2="Shadow Ring",
		back="Engulfer Cape",]]waist="Flume Belt",legs="Bihu Cannions",feet="Gende. Galosh. +1"}

	sets.Kiting = {feet="Aoidos' Cothurnes +2"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {head="Nahtirah Hat",neck="Houyi's Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Bihu Justaucorps",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Bihu Cannions +1",feet="Gende. galosh. +1"}

	-- Sets with weapons defined.
	sets.engaged.Dagger = {head="Nahtirah Hat",neck="Houyi's Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Bihu Justaucorps",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Bihu Cannions +1",feet="Gende. galosh. +1"}

	-- Set if dual-wielding
	sets.engaged.DualWield = {
		head="Nahtirah Hat",neck="Houyi's Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Bihu Justaucorps",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Bihu Cannions +1",feet="Gende. galosh. +1"}
	sets.precast.WS = {head="Nahtirah Hat",neck="Houyi's Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Bihu Justaucorps",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Bihu Cannions +1",feet="Gende. galosh. +1"
		}

	brd_daggers = {'Izhiikoh', 'Vanir Knife', 'Legato Dagger', 'Aphotic Kukri'}
end


-------------------------------------------------------------------------------------------------------------------
-- Job- versions of event handlers, allowing overriding default handling.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'BardSong' then
		-- Auto-Pianissimo
		if spell.target.type == 'PLAYER' and not spell.target.charmed and not state.Buff['Pianissimo'] then
			cancel_spell()
			send_command('@input /ja "Pianissimo" <me>; wait 1.25; input /ma "'..spell.name..'" '..spell.target.name)
			eventArgs.cancel = true
			return
		end
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)

		if spell.type == 'BardSong' then
			-- layer general gear on first, then let default handler add song-specific gear.
			local generalClass = get_song_class(spell)
			if generalClass and sets.midcast[generalClass] then
				equip(sets.midcast[generalClass])
			end
		end
	end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.name] ~= nil then
			state.Buff[spell.name] = true
		end

		if spell.type == 'BardSong' then
			if spell.target then
				if spell.target.type and spell.target.type:upper() == 'SELF' then
					adjust_Timers(spell, action, spellMap)
				end
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for other events that aren't handled by the include file.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------




-- Handle notifications of general user state change.
function job_state_change(stateField, newValue)
	if stateField == 'OffenseMode' then
		if newValue == 'Normal' then
			disable('main','sub')
		else
			enable('main','sub')
		end
	elseif stateField == 'Reset' then
		if state.OffenseMode == 'None' then
			enable('main','sub')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
	if DaurdSongs[spell.english] then
		return 'Daurdabla'
	elseif spell.target.type == 'MONSTER' then
		return 'SongDebuff'
	else
		return 'SongEffect'
	end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_Timers(spell, action, spellMap)
	local t = os.time()
	
	-- Eliminate songs that have already expired from our local list.
	local tempreg = {}
	for i,v in pairs(timer_reg) do
		if v < t then tempreg[i] = true end
	end
	for i,v in pairs(tempreg) do
		timer_reg[i] = nil
	end
	
	local dur = calculate_duration(spell.name, spellMap)
	if timer_reg[spell.name] then
		-- Can delete timers that have less than 120 seconds remaining, since
		-- the new version of the song will overwrite the old one.
		-- Otherwise create a new timer counting down til we can overwrite.
		if (timer_reg[spell.name] - t) <= 120 then
			send_command('timers delete "'..spell.name..'"')
			timer_reg[spell.name] = t + dur
			send_command('timers create "'..spell.name..'" '..dur..' down')
		end
	else
		-- Figure out how many songs we can maintain.
		local maxsongs = 2
		if player.equipment.range == 'Daurdabla' then
			maxsongs = maxsongs+1 -- +2 for 99 Daur
		end
		if buffactive['Clarion Call'] then
			maxsongs = maxsongs+1
		end
		-- If we have more songs active than is currently apparent, we can still overwrite
		-- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
		if maxsongs < table.length(timer_reg) then
			maxsongs = table.length(timer_reg)
		end
		
		-- Create or update new song timers.
		if table.length(timer_reg) < maxsongs then
			timer_reg[spell.name] = t+dur
			send_command('timers create "'..spell.name..'" '..dur..' down')
		else
			local rep,repsong
			for i,v in pairs(timer_reg) do
				if t+dur > v then
					if not rep or rep > v then
						rep = v
						repsong = i
					end
				end
			end
			if repsong then
				timer_reg[repsong] = nil
				send_command('timers delete "'..repsong..'"')
				timer_reg[spell.name] = t+dur
				send_command('timers create "'..spell.name..'" '..dur..' down')
			end
		end
	end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_Timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
	local mult = 1
	if player.equipment.range == 'Daurdabla' then mult = mult + 0.25 end -- change to 0.3 with 95/99 Daur
	if player.equipment.range == "Gjallarhorn" then mult = mult + 0.3 end -- change to 0.4 with 99 Gjall
	
	if player.equipment.main == "Carnwenhan" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
	if player.equipment.main == "Legato Dagger" then mult = mult + 0.1 end
	if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
	if player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
	if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
	if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
	if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
	
	if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
	if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
	if spellMap == 'Madrigal' and player.equipment.head == "Aoidos' Calot +2" then mult = mult + 0.1 end
	if spellMap == 'Minuet' and player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
	if spellMap == 'March' and player.equipment.hands == 'Ad. Mnchtte. +2' then mult = mult + 0.1 end
	if spellMap == 'Ballad' and player.equipment.legs == "Aoidos' Rhing. +2" then mult = mult + 0.1 end
	if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Aoidos' Cothrn. +2" then mult = mult + 0.1 end
	
	if buffactive.Troubadour then
		mult = mult*2
	end
	if spellName == "Sentinel's Scherzo" then
		if buffactive['Soul Voice'] then
			mult = mult*2
		elseif buffactive['Marcato'] then
			mult = mult*1.5
		end
	end
	
	-- Tweak for inaccuracies in cast vs aftercast timing
	mult = mult - 0.05
	
	local totalDuration = mult*120

	return totalDuration
end


-- Examine equipment to determine what our current TP weapon is.