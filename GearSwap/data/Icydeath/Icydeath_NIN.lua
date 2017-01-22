-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Ninja Kyahan +1"
    
    select_movement_feet()
    --select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
	organizer_items = {
		echos="Echo Drops",
		shihei="Shihei",
		capring="Capacity Ring"
	}
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {} --legs="Mochizuki Hakama"
    sets.precast.JA['Futae'] = {} --legs="Iga Tekko +2"
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {left_ear="Choreia Earring", waist="Chaac Belt"}

    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		ammo="Impatiens",
		body="Dread Jupon",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Prolix Ring",
	}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- Snapshot for ranged
    sets.precast.RA = {}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Happo Shuriken",
		head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','Weapon skill damage +1%','Attack+5',}},
		feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Steelflash Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +25',}},
		left_ring="Petrov Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Yokaze Mantle", augments={'STR+3','Sklchn.dmg.+2%','Weapon skill damage +3%',}},
	}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    --sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,
    --    {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",feet="Daihanshi Habaki"})

    --sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,
    --    {head="Felistris Mask",hands="Hachiya Tekko",ring1="Stormsoul Ring",legs="Nahtirah Trousers"})

    --sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {feet="Daihanshi Habaki"})


    --sets.precast.WS['Aeolian Edge'] = {}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}
        
    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {}) --feet="Iga Kyahan +2"

    sets.midcast.ElementalNinjutsu = {}

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {})

    sets.midcast.NinjutsuDebuff = {}

    sets.midcast.NinjutsuBuff = {head="Hachiya Hatsuburi",neck="Ninjutsu Torque"}

    sets.midcast.RA = {}
    -- Hachiya Hakama/Thurandaut Tights +1

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {
		ammo="Demonry Stone",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body="Mekosu. Harness",
		hands="Kurys Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+23 Attack+23','"Dual Wield"+1','AGI+3','Accuracy+15','Attack+15',}},
		feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Infused Earring",
		right_ear="Etiolation Earring",
		left_ring="Sheltered Ring",
		right_ring="Paguroidea Ring",
		back="Xucau Mantle",
	}

    --sets.idle.Town = {main="Raimitsukane",sub="Kaitsuburi",ammo="Qirmiz Tathlum",
    --    head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Hachiya Chainmail +1",hands="Otronif Gloves +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
    --    back="Atheling Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet=gear.MovementFeet}
    
    --sets.idle.Weak = {
    --    head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
    --    body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
    --    back="Shadow Mantle",waist="Flume Belt",legs="Hachiya Hakama",feet=gear.MovementFeet}
    
    -- Defense sets
    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}


    sets.Kiting = {feet=gear.MovementFeet}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		ammo="Ginsen",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+23 Attack+23','"Dual Wield"+1','AGI+3','Accuracy+15','Attack+15',}},
		feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+4','Attack+7',}},
		neck="Lissome Necklace",
		waist="Grunfeld Rope",
		left_ear="Dudgeon Earring",
		right_ear="Heartseeker Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back="Yokaze Mantle",
	}
    sets.engaged.Acc = {}
    sets.engaged.Evasion = {}
    sets.engaged.Acc.Evasion = {}
    sets.engaged.PDT = {}
    sets.engaged.Acc.PDT = {}

    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = {
		ammo="Ginsen",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+23 Attack+23','"Dual Wield"+1','AGI+3','Accuracy+15','Attack+15',}},
		feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+4','Attack+7',}},
		neck="Lissome Necklace",
		waist="Grunfeld Rope",
		left_ear="Dudgeon Earring",
		right_ear="Heartseeker Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back="Yokaze Mantle",
	}
    sets.engaged.Acc.HighHaste = {}
    sets.engaged.Evasion.HighHaste = {}
    sets.engaged.Acc.Evasion.HighHaste = {}
    sets.engaged.PDT.HighHaste = {}
    sets.engaged.Acc.PDT.HighHaste = {}

    -- Custom melee group: Embrava Haste (7% DW)
    sets.engaged.EmbravaHaste = {}
    sets.engaged.Acc.EmbravaHaste = {}
    sets.engaged.Evasion.EmbravaHaste = {}
    sets.engaged.Acc.Evasion.EmbravaHaste = {}
    sets.engaged.PDT.EmbravaHaste = {}
    sets.engaged.Acc.PDT.EmbravaHaste = {}

    -- Custom melee group: Max Haste (0% DW)
    sets.engaged.MaxHaste = {
		ammo="Ginsen",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+21 Attack+21','"Triple Atk."+3','STR+9','Accuracy+15','Attack+9',}},
		legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+4','Attack+7',}},
		neck="Lissome Necklace",
		waist="Grunfeld Rope",
		left_ear="Steelflash Earring",
		right_ear="Bladeborn Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back="Yokaze Mantle",
	}
    sets.engaged.Acc.MaxHaste = {}
    sets.engaged.Evasion.MaxHaste = {}
    sets.engaged.Acc.Evasion.MaxHaste = {}
    sets.engaged.PDT.MaxHaste = {}
    sets.engaged.Acc.PDT.MaxHaste = {}


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Iga Ningi +2"}
    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(5, 3)
    else
        set_macro_page(1, 3)
    end
end