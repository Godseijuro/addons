-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]

--[[
		Skillchains using Immanence
		
		Immanence needs to be used before casting each spell.

		Fusion (Fire, Light) - Level 2
			Fire Magic > Lightning Magic
		Fragmentation (Wind, Lightning) - Level 2
			Ice Magic > Water Magic
		Distortion (Ice, Water) - Level 2
			Light Magic > Earth Magic
		Gravitation (Earth, Dark) - Level 2
			Wind Magic > Dark Magic
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	
	-- Load and initialize the include file.
    include('Mote-Include.lua')
	
	-- Organizer library
	include('organizer-lib.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')


    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
	
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
					   
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

	
	gear.default.obi_waist = "Yamabuki-no-Obi"
	gear.ElementalObi = {name="Hachirin-no-Obi"}
	gear.ElementalBack = {name="Twilight Cape"}
	
    --send_command('bind ^` input /ma Stun <t>')

    --select_default_macro_book()
end

function user_unload()
    send_command('unbind ^`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	organizer_items = {echos="Echo Drops"}

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants"}


    -- Fast cast sets for spells
	
    sets.precast.FC = {
		main={ name="Coeus", augments={'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
		sub="Oneiros Grip",
		ammo="Incantor Stone",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+3','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
		body="Vanir Cotehardie",
		hands={ name="Helios Gloves", augments={'Mag. Acc.+25','"Fast Cast"+3','Mag. crit. hit dmg. +8%',}},
		legs="Lengo Pants",
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+22','Magic burst mdg.+7%','INT+4','Mag. Acc.+15',}},
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		back="Swith Cape",
	}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		neck="Stoicheion Medal",
		left_ear="Barkarole Earring",
		waist="Channeler's Stone" --equips this so we don't screw ourselves with an insta-cast
	})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		legs="Praeco Slacks",
		right_ring="Veneficium Ring",
		back="Disperser's Cape"
	})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {}) --head=empty,body="Twilight Cloak"


    -- Midcast Sets			
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		-- Haste gear.. if u want...
		
	})

    sets.midcast.Cure = {
		main="Chatoyant Staff",
		sub="Benthos Grip",
		ammo="Kalboron Stone",
		head="Vanya Hood",
		body="Nefer Kalasiris",
		hands="Telchine Gloves",
		legs="Praeco Slacks",
		feet={ name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}},
		neck="Weike Torque",
		waist=gear.ElementalObi,
		left_ear="Aredan Earring",
		right_ear="Lifestorm Earring",
		left_ring="Prolix Ring",
		right_ring="Veneficium Ring",
		back="Disperser's Cape",
	}

    sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure, {
		waist=gear.ElementalObi
	})

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Cursna = {}

    sets.midcast['Enhancing Magic'] = {
		main={ name="Coeus", augments={'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
		sub="Fulcio Grip",
		ammo="Kalboron Stone",
		head="Befouled Crown",
		body="Telchine Chas.",
		hands="Telchine Gloves",
		legs="Arbatel Pants",
		feet="Regal Pumps",
		neck="Weike Torque",
		waist="Olympus Sash",
		left_ear="Aredan Earring",
		right_ear="Lifestorm Earring",
		left_ring={ name="Diamond Ring", augments={'INT+2','Spell interruption rate down -3%','MND+2',}},
		right_ring="Globidonta Ring",
		back="Merciful Cape",
	}
	
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		head="Arbatel Bonnet",
		back="Bookworm's Cape",
		
	})
	
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers"})

    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
		main={ name="Coeus", augments={'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
		sub="Mephitis Grip",
		ammo="Kalboron Stone",
		head="Befouled Crown",
		body="Vanir Cotehardie",
		hands={ name="Peda. Bracers", augments={'Enh. "Tranquility" and "Equanimity"',}},
		legs="Amalric Slops",
		feet={ name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}},
		neck="Weike Torque",
		waist=gear.ElementalObi,
		left_ear="Aredan Earring",
		right_ear="Gwati Earring",
		left_ring="Balrahn's Ring",
		right_ring="Globidonta Ring",
		back="Ogapepo Cape",
	}

    sets.midcast.IntEnfeebles = {
		main={ name="Coeus", augments={'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
		sub="Mephitis Grip",
		ammo="Kalboron Stone",
		head="Befouled Crown",
		body="Vanir Cotehardie",
		hands={ name="Peda. Bracers", augments={'Enh. "Tranquility" and "Equanimity"',}},
		legs="Lengo Pants",
		feet={ name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}},
		neck="Weike Torque",
		waist=gear.ElementalObi,
		left_ear="Enfeebling Earring",
		right_ear="Aredan Earring",
		left_ring="Balrahn's Ring",
		right_ring={ name="Diamond Ring", augments={'INT+2','Spell interruption rate down -3%','MND+2',}},
		back="Ogapepo Cape",
	}

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = {
		main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
		sub="Genbu's Shield",
		ammo="Kalboron Stone",
		head="Pixie Hairpin +1",
		body="Gyve Doublet",
		hands={ name="Helios Gloves", augments={'Mag. Acc.+25','"Fast Cast"+3','Mag. crit. hit dmg. +8%',}},
		legs="Lengo Pants",
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+22','Magic burst mdg.+7%','INT+4','Mag. Acc.+15',}},
		neck="Deceiver's Torque",
		waist=gear.ElementalObi,
		left_ear="Aredan Earring",
		right_ear="Gwati Earring",
		left_ring="Archon Ring",
		right_ring="Fenrir Ring +1",
		back="Toro Cape",
	}

    sets.midcast.Kaustra = set_combine(sets.midcast['Dark Magic'], {
		
	})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		waist="Fucho-no-obi",
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+22','Magic burst mdg.+7%','INT+4','Mag. Acc.+15',}},
	})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		
	})

    sets.midcast.Stun.Resistant = sets.midcast.Stun


    -- Elemental Magic sets are default for handling low-tier nukes.
	-- 		this is where Magic Damage does better than MAB
    sets.midcast['Elemental Magic'] = {
		main="Akademos",
		sub="Niobid Strap",
		ammo="Kalboron Stone",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+3','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
		body="Witching Robe",
		hands={ name="Helios Gloves", augments={'Mag. Acc.+25','"Fast Cast"+3','Mag. crit. hit dmg. +8%',}},
		legs={ name="Amalric Slops", augments={'MP+60','"Mag. Atk. Bns."+15','Mag. Acc.+15',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+22','Magic burst mdg.+7%','INT+4','Mag. Acc.+15',}},
		neck="Satlada Necklace",
		waist=gear.ElementalObi,
		left_ear="Barkaro. Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Fenrir Ring +1",
		back={ name="Bookworm's Cape", augments={'INT+3','Helix eff. dur. +19','"Regen" potency+2',}},
	}

    sets.midcast['Elemental Magic'].Resistant = {
		main="Akademos",
		sub="Niobid Strap",
		ammo="Kalboron Stone",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+3','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
		body="Witching Robe",
		hands={ name="Helios Gloves", augments={'Mag. Acc.+25','"Fast Cast"+3','Mag. crit. hit dmg. +8%',}},
		legs={ name="Amalric Slops", augments={'MP+60','"Mag. Atk. Bns."+15','Mag. Acc.+15',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+22','Magic burst mdg.+7%','INT+4','Mag. Acc.+15',}},
		neck="Satlada Necklace",
		waist=gear.ElementalObi,
		left_ear="Barkaro. Earring",
		right_ear="Gwati Earring",
		left_ring="Balrahn's Ring",
		right_ring="Fenrir Ring +1",
		back={ name="Bookworm's Cape", augments={'INT+3','Helix eff. dur. +19','"Regen" potency+2',}},
	}

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = {
		main="Akademos",
		sub="Niobid Strap",
		ammo="Kalboron Stone",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+3','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
		body="Gyve Doublet",
		hands={ name="Helios Gloves", augments={'Mag. Acc.+25','"Fast Cast"+3','Mag. crit. hit dmg. +8%',}},
		legs={ name="Amalric Slops", augments={'MP+60','"Mag. Atk. Bns."+15','Mag. Acc.+15',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+22','Magic burst mdg.+7%','INT+4','Mag. Acc.+15',}},
		neck="Mizu. Kubikazari",
		waist=gear.ElementalObi,
		left_ear="Barkaro. Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Fenrir Ring +1",
		back={ name="Bookworm's Cape", augments={'INT+3','Helix eff. dur. +19','"Regen" potency+2',}},
	}

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {
		main="Akademos",
		sub="Benthos Grip",
		ammo="Kalboron Stone",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+3','Mag. Acc.+15','"Mag.Atk.Bns."+11',}},
		body="Gyve Doublet",
		hands={ name="Helios Gloves", augments={'Mag. Acc.+25','"Fast Cast"+3','Mag. crit. hit dmg. +8%',}},
		legs={ name="Amalric Slops", augments={'MP+60','"Mag. Atk. Bns."+15','Mag. Acc.+15',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+22','Magic burst mdg.+7%','INT+4','Mag. Acc.+15',}},
		neck="Stoicheion Medal",
		waist=gear.ElementalObi,
		left_ear="Barkaro. Earring",
		right_ear="Gwati Earring",
		left_ring="Balrahn's Ring",
		right_ring="Fenrir Ring +1",
		back={ name="Bookworm's Cape", augments={'INT+3','Helix eff. dur. +19','"Regen" potency+2',}},
	}

    sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {
		
	})

	
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle.Town = {
		main="Akademos",
		sub="Oneiros Grip",
		ammo="Homiliary",
		body="Respite Cloak",
		hands="Serpentes Cuffs",
		legs="Lengo Pants",
		feet="Serpentes Sabots",
		neck="Twilight Torque",
		waist="Porous Rope",
		left_ear="Sanare Earring",
		right_ear="Infused Earring",
		left_ring="Sheltered Ring",
		right_ring={ name="Dark Ring", augments={'Magic dmg. taken -5%','Phys. dmg. taken -5%',}},
		back={ name="Bookworm's Cape", augments={'INT+3','Helix eff. dur. +19','"Regen" potency+2',}},
	}

	sets.idle.Field = {
		main="Akademos",
		sub="Oneiros Grip",
		ammo="Homiliary",
		body="Respite Cloak",
		hands="Serpentes Cuffs",
		legs="Lengo Pants",
		feet="Serpentes Sabots",
		neck="Twilight Torque",
		waist="Porous Rope",
		left_ear="Sanare Earring",
		right_ear="Infused Earring",
		left_ring="Sheltered Ring",
		right_ring="Paguroidea Ring",
		back={ name="Bookworm's Cape", augments={'INT+3','Helix eff. dur. +19','"Regen" potency+2',}},
	}

	sets.idle.Field.PDT = {}

	sets.idle.Field.Stun = {}

	sets.idle.Weak = {}

    -- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

    sets.Kiting = {} --feet="Herald's Gaiters"

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {}
	
	
	-- Resting sets
    sets.resting = set_combine(sets.idle.Field, {
		main="Chatoyant Staff"
	})
	
		
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers"}
    sets.buff['Penury'] = {legs="Arbatel Pants"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants"}
    sets.buff['Celerity'] = {feet="Pedagogy Loafers"}
    sets.buff['Alacrity'] = {feet="Pedagogy Loafers"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers"}

	-- Sublimation
    sets.buff.FullSublimation = {
		main="Akademos",
		sub="Oneiros Grip",
		ammo="Homiliary",
		head="Acad. Mortarboard",
		body="Witching Robe",
		hands="Serpentes Cuffs",
		legs="Lengo Pants",
		feet="Serpentes Sabots",
		neck="Weike Torque",
		waist="Fucho-no-Obi",
		left_ear="Barkaro. Earring",
		right_ear="Loquac. Earring",
		left_ring="Sheltered Ring",
		right_ring="Paguroidea Ring",
		back="Twilight Cape",
	}
		
    sets.buff.PDTSublimation = sets.buff.FullSublimation

    --sets.buff['Sandstorm'] = {feet="Desert Boots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
end


-- Aftercast handler
function job_aftercast(spell,arg)
	sleep_timers(spell)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts'] or buffactive['dark arts'] or buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)    	
	if player.equipment.back == 'Mecisto. Mantle' or player.equipment.back == 'Aptitude Mantle' or player.equipment.back == 'Aptitude Mantle +1' then
		disable('back')
	else
		enable('back')
	end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end

-- Sleep Timers
function sleep_timers(spell)	
	if spell.name == "Sleep II" or spell.name == "Sleepga II" or spell.name == "Repose" or spell.name == "Dream Flower" or spell.name == "Yawn" then
		windower.send_command('wait 75;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:15 ]')
		windower.send_command('wait 80;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:10 ]')
		windower.send_command('wait 85;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:05 ]')
	elseif spell.name == "Sleep" or spell.name == "Sleepga" then
		windower.send_command('wait 45;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:15 ]')
		windower.send_command('wait 50;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:10 ]')
		windower.send_command('wait 55;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:05 ]')
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 20)
end

