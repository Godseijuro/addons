--[[***************************************************************************
    NOTE: Make sure to have the AddOn: Shortcuts running
	
	Recommended in game macros to use:
            Macro Syntax             States
    -----------------------|----------------------
    /con gs c auto_action  |  Off / On
    /con gs c cure         |  Dynamic Cure macro - Will use currently set spell
    /con gs c dt_mode      |  None / Active
    /con gs c tp_mode      |  Normal / Accuracy Mid / Accuracy High
    /con gs c weapon_combo |  Soluis / Iris


    TIMERS PLUGIN: File includes custom timers:
          Type                 Location
    ------------------|--------------------------
    Mythic Aftermath  |  buff_change / aftercast
    Dream Flower      |  aftercast
    Transcendency     |  buff_change
    Weakness          |  buff_change


    F10 is bound as a weaponskill macro, I use a controller and remap the R1
    button to F10 for fast weaponskills
	
	TODO: Add an Enhancing Set
*****************************************************************************]]

function get_sets()
	include('organizer-lib')
	
    -- Spell maps are moved to their own function to assit in easier navigation
    get_maps()

    --windower.send_command('input /macro book 1; wait .1; input /macro set 1')
    --windower.send_command('input /echo [ Job Changed to BLU ]')
    windower.send_command('bind f10 gs c tryweaponskill')
    --windower.send_command('input /blockhelp on')


    windower.register_event('tp change', function(new, old)
        if new > 349
                and auto_action == 'On'
                and player.status == 'Engaged' then
            relaxed_play_mode()
        end
    end)

    windower.register_event('time change', function(time)
        if player.tp == 3000
                and auto_action == 'On'
                and player.status == 'Engaged' then
            relaxed_play_mode()
        end
    end)
	
    -- Start defining actual gear sets to be used below --
    -- WEAPON TYPES --
    sets.weapon = {}
    sets.weapon.Soluis = {
        main="Claidheamh Soluis",
        sub="Nibiru Blade"}

    sets.weapon.Iris = {
        main="Iris",
        sub="Iris"}


    -- MISCELLANEOUS SETS --
    sets.misc = {}
    sets.misc.DT = {}
    sets.misc.DT.None = {}
    sets.misc.DT.Active = {
        neck="Twilight Torque",
		rear="Ethereal Earring",
		lring="Patricius Ring",
        rring="Dark Ring",
        waist="Flume Belt +1"}

    sets.misc['Chain Affinity'] = {
		head="Hashishin Kavuk",
        --feet="Assimilator's Charuqs"
	}

    sets.misc.Efflux = {
        head="Hashishin Kavuk",
        legs="Hashishin Tayt +1"}

    sets.misc.Diffusion = {
        feet="Luhlaza Charuqs"}

    sets.misc.Movement = {
        legs="Crimson Cuisses"}

    sets.misc.Learn = {
        ammo="Mavi Tathlum",
		neck="Deceiver's Torque",
        head="Luhlaza Keffiyeh",
        body="Assimilator's Jubbah",
        hands="Assimilator's Bazubands",
        back="Cornflower Cape",
        legs="Hashishin Tayt +1",
        feet="Luhlaza Charuqs"}

    sets.misc.Obi = {waist="Hachirin-no-Obi"}

    sets.misc.Reive = {neck="Arciela's Grace +1"}


    -- PRECAST SETS --
    sets.precast = {}
    sets.precast.JA = {}
    sets.precast.JA['Azure Lore'] = {
        hands="Luhlaza Bazubands"}

    sets.precast.WS = {}
	-- DEX-80% | Light/Flame/Thunder/Breeze
    sets.precast.WS['Chant du Cygne'] = {
		ammo="Jukukik Feather",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body="Adhemar Jacket",
		hands={ name="Taeon Gloves", augments={'Accuracy+15 Attack+15','"Triple Atk."+2','STR+9',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+25','Attack+7','"Triple Atk."+4',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Steelflash Earring",
		right_ear="Bladeborn Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back="Sokolski Mantle",
	}

	-- STR-30%/DEX-30%/INT-30% | Aqua/Snow/Soil
    sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS['Chant du Cygne'], {
		neck="Fotia Gorget",
		waist="Fotia Belt"})

	-- MND-73~85% | Shadow/Soil
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Chant du Cygne'], {
		body="Gyve Doublet",
		legs={ name="Herculean Trousers", augments={'Accuracy+23 Attack+23','"Dual Wield"+1','AGI+3','Accuracy+15','Attack+15',}},
		neck="Fotia Gorget",
		waist="Fotia Belt"
	})

	-- STR-30%/MND-50% | MAB+ makes this very potent - INT will also help
    sets.precast.WS['Sanguine Blade'] = {
        head="Pixie Hairpin +1",
		head="Helios Band",
        neck="Stoicheion Medal",
        body="Gyve Doublet",
        hands="Hashishin Bazubands",
		legs="Amalric Slops",
        feet={ name="Herculean Boots", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Store TP"+1','STR+1','"Mag.Atk.Bns."+15',}},
        lear="Friomisi Earring",
        rear="Hecate's Earring",
        lring="Fenrir Ring +1",
        rring="Diamond Ring",
        back="Cornflower Cape",
        waist="Yamabuki-no-Obi"}

    sets.precast.FastCast = {
        ammo="Impatiens",
		head={ name="Helios Band", augments={'Mag. Acc.+22','"Fast Cast"+4','INT+9',}},
		body="Dread Jupon",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Lengo Pants",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Prolix Ring",
		back="Swith Cape",
        waist="Witful Belt"
	}

    sets.precast.FastCast.BlueMagic = set_combine(sets.precast.FastCast, {body="Hashishin Mintan"})


    -- MIDCAST SETS --
    sets.midcast = {}
    sets.midcast.BlueMagic = {}
    sets.midcast.BlueMagic.Skill = {
		ammo="Mavi Tathlum",
		head="Luhlaza Keffiyeh",
		hands="Fea's Cuffs",
		body="Assimilator's Jubbah",
		legs="Hashishin Tayt +1",
		feet="Luhlaza Charuqs",
		neck="Deceiver's Torque",
		back="Cornflower Cape"
	}

    sets.midcast.BlueMagic.SkillDarkAff = set_combine(sets.midcast.BlueMagic.Skill, {
        head="Pixie Hairpin +1",
        rring="Archon Ring"})

    sets.midcast.BlueMagic.STR = {
		ammo="Mavi Tathlum",
		head={ name="Taeon Chapeau", augments={'Accuracy+18','"Dual Wield"+4','STR+7 AGI+7',}},
		body="Dread Jupon",
		hands={ name="Taeon Gloves", augments={'Accuracy+15 Attack+15','"Triple Atk."+2','STR+9',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+25','Attack+7','"Triple Atk."+4',}},
		neck="Lacono Neck. +1",
		waist="Grunfeld Rope",
		left_ear="Flame Pearl",
		left_ring="Ifrit Ring",
		right_ring="Strigoi Ring",
		back="Cornflower Cape"
	}

    sets.midcast.BlueMagic.DEX = set_combine(sets.midcast.BlueMagic.STR, {
		ammo="Jukukik Feather",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body="Adhemar Jacket",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+25','Attack+7','"Triple Atk."+4',}},
		waist="Grunfeld Rope",
		left_ring="Apate Ring",
		right_ring="Thundersoul Ring",
	})

    sets.midcast.BlueMagic.VIT = set_combine(sets.midcast.BlueMagic.STR, {
        })

    sets.midcast.BlueMagic.AGI = set_combine(sets.midcast.BlueMagic.STR, {
        })

    sets.midcast.BlueMagic.MND = set_combine(sets.midcast.BlueMagic.STR, {
        neck="Weike Torque",
        hands="Telchine Gloves",
        rring="Globidonta Ring",
        legs="Amalric Slops"})

    sets.midcast.BlueMagic.INT = set_combine(sets.midcast.BlueMagic.STR, {
        })

    sets.midcast.BlueMagic.CHR = set_combine(sets.midcast.BlueMagic.STR, {
        })

    sets.midcast.BlueMagic.PhysACC = set_combine(sets.midcast.BlueMagic.STR, {
        ammo="Hasty Pinion +1",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body="Adhemar Jacket",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+23 Attack+23','"Dual Wield"+1','AGI+3','Accuracy+15','Attack+15',}},
		feet={ name="Herculean Boots", augments={'Accuracy+25','Attack+7','"Triple Atk."+4',}},
		neck="Subtlety Spec.",
		waist="Grunfeld Rope",
		left_ear="Heartseeker Earring",
		right_ear="Steelflash Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Patricius Ring",
		back="Cornflower Cape"
	})

    sets.midcast.BlueMagic.MagicACC = set_combine(sets.midcast.BlueMagic.Skill, {
		ammo="Mavi Tathlum",
		head={ name="Helios Band", augments={'Mag. Acc.+22','"Fast Cast"+4','INT+9',}},
		body="Amalric Doublet",
		hands="Leyline Gloves",
		legs="Amalric Slops",
		feet={ name="Herculean Boots", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Store TP"+1','STR+1','"Mag.Atk.Bns."+15',}},
		neck="Deceiver's Torque",
		waist="Yamabuki-no-Obi",
		left_ear="Gwati Earring",
		left_ring="Fenrir Ring +1",
		right_ring="Balrahn's Ring",
		back="Cornflower Cape"
	})

    sets.midcast.BlueMagic.PhysMagicACC = set_combine(sets.midcast.BlueMagic.PhysACC, {
	
	})

    sets.midcast.BlueMagic.Nuke = {
        ammo="Mavi Tathlum",
		head={ name="Helios Band", augments={'Mag. Acc.+22','"Fast Cast"+4','INT+9',}},
		body="Gyve Doublet",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Amalric Slops",
		feet={ name="Herculean Boots", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Store TP"+1','STR+1','"Mag.Atk.Bns."+15',}},
		neck="Stoicheion Medal",
		waist="Yamabuki-no-Obi",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Fenrir Ring +1",
		right_ring="Acumen Ring",
		back="Cornflower Cape"
	}

    sets.midcast.BlueMagic.NukeDarkAff = set_combine(sets.midcast.BlueMagic.Nuke, {head="Pixie Hairpin +1"})

    sets.midcast.BlueMagic.NukeLightAff = set_combine(sets.midcast.BlueMagic.Nuke, {})

    sets.midcast.BlueMagic.Breath = set_combine(sets.midcast.BlueMagic.Nuke, {ammo="Mavi Tathlum", head="Luhlaza Keffiyeh"})

    sets.midcast.BlueMagic.Healing = set_combine(sets.midcast.BlueMagic.MND, {
		})

    sets.midcast.BlueMagic.Healing.Self = set_combine(sets.midcast.BlueMagic.Healing, {
		})

    sets.midcast.BlueMagic.HealingMAXHP = set_combine(sets.midcast.BlueMagic.Healing, {
		})

    sets.midcast.BlueMagic.Recast = {hands="Hashi. Bazubands"}


    -- AFTERCAST SETS --
    -- Labelled to show either TP or idle --
    --[[ After looking into different ways to set_combine the different levels
            of Accuracy and Uncapped/Capped Magic Haste it seemed cleaner and
            easier to hardcode each set
            There is a fair amount of redundancy however this way should be
            easier on the end user ]]
			
    -- initialized arrays no need to add stuff to these.
	sets.TP = {}
    sets.TP['Magic Haste Uncapped'] = {}
    sets.TP['Magic Haste Capped'] = {}
	
    sets.TP['Magic Haste Uncapped']['Normal'] = {
        ammo="Ginsen",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body="Adhemar Jacket",
		hands={ name="Taeon Gloves", augments={'Accuracy+15 Attack+15','"Triple Atk."+2','STR+9',}},
		--legs={ name="Herculean Trousers", augments={'Accuracy+23 Attack+23','"Dual Wield"+1','AGI+3','Accuracy+15','Attack+15',}},
		legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'Accuracy+25','Attack+7','"Triple Atk."+4',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Dudgeon Earring",
		right_ear="Heartseeker Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back="Sokolski Mantle"
	}

    sets.TP['Magic Haste Capped']['Normal'] = sets.TP['Magic Haste Uncapped']['Normal']
	
    sets.TP['Magic Haste Uncapped']['Accuracy Mid'] = {
		main={ name="Claidheamh Soluis", augments={'Accuracy+14','"Dbl.Atk."+2','DMG:+19',}},
		sub={ name="Nibiru Blade", augments={'DEX+10','Accuracy+20','Mag. Acc.+15',}},
		ammo="Ginsen",
		head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Taeon Gloves", augments={'Accuracy+15 Attack+15','"Triple Atk."+2','STR+9',}},
		--legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+23 Attack+23','"Dual Wield"+1','AGI+3','Accuracy+15','Attack+15',}},
		feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+4','Attack+7',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back="Sokolski Mantle",
	}

    sets.TP['Magic Haste Capped']['Accuracy Mid'] = sets.TP['Magic Haste Uncapped']['Accuracy Mid']

    sets.TP['Magic Haste Uncapped']['Accuracy High'] = sets.TP['Magic Haste Uncapped']['Accuracy Mid']

    sets.TP['Magic Haste Capped']['Accuracy High'] = sets.TP['Magic Haste Uncapped']['Accuracy Mid']

    sets.idle = {
		ammo="Ginsen",
		head="Rawhide Mask",
		body="Mekosu. Harness",
		hands="Serpentes Cuffs",
		legs="Crimson Cuisses",
		feet="Serpentes Sabots",
		neck="Lissome Necklace",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Infused Earring",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -5%','Phys. dmg. taken -5%',}},
		right_ring="Patricius Ring",
		back="Cornflower Cape"
	}

    sets.idle.SphereRefresh = {
        body="Mekosu. Harness"}

    sets.idle.under_50mpp = {
        waist="Fucho-no-Obi"}
	
	sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
	
    -- VARIABLES --
    auto_action = 'Off'
    count_msg_mecisto = 0
    dt_mode = 'None'
    gear_change_ok = true
    tp_mode = 'Normal'
    shadow_type = 'None'
    weapon_combo = 'Soluis'
end

function get_maps()
    -- Map for Aftermath times
    mythic_aftermath_times = {
        ["Aftermath: Lv.1"]=90,
        ["Aftermath: Lv.2"]=270,
        ["Aftermath: Lv.3"]=180}

    -- Map for auto activation of Berserk/Warcry based
    -- on Weaponskills listed
    berserk_warcry_automation = S{
        'Chant du Cygne',
        'Expiacion',
        'Realmrazer',
        'Requiescat'}

    -- Maps Blue Mage spell Stats per spell for the midcast function,
    -- Currently 178 spells mapped, can change mapping as needed
    modifiers = {}
    -- PHYSICAL MODIFIERS
    modifiers.STR = S{
        'Battle Dance',
        'Bloodrake',
        'Death Scissors',
        'Dimensional Death',
        'Empty Thrash',
        'Quadrastrike',
        'Sinker Drill',
        'Smite of Rage',
        'Spinal Cleave',
        'Uppercut',
        'Vertical Cleave'}
    modifiers.DEX = S{
        'Amorphic Spikes',
        'Asuran Claws',
        'Barbed Crescent',
        'Claw Cyclone',
        'Disseverment',
        'Foot Kick',
        'Frenetic Rip',
        'Goblin Rush',
        'Hysteric Barrage',
        'Paralyzing Triad',
        'Seedspray',
        'Sickle Slash',
        'Terror Touch',
        'Thrashing Assault',
        'Vanity Dive'}
    modifiers.VIT = S{
        'Body Slam',
        'Cannonball',
        'Delta Thrust',
        'Glutinous Dart',
        'Grand Slam',
        'Power Attack',
        'Quad. Continuum',
        'Saurian Slide',
        'Sprout Smack',
        'Sub-zero Smash'}
    modifiers.AGI = S{
        'Benthic Typhoon',
        'Feather Storm',
        'Final Sting',
        'Helldive',
        'Hydro Shot',
        'Jet Stream',
        'Pinecone Bomb',
        'Spiral Spin',
        'Wild Oats'}
    modifiers.INT = S{
        'Mandibular Bite',
        'Queasyshroom'}
    modifiers.MND = S{
        'Ram Charge',
        'Screwdriver'}
    modifiers.CHR = S{
        'Bludgeon'}
    modifiers.PhysACC = S{
        'Heavy Strike'}
    modifiers.PhysMagicACC = S{
        'Bilgestorm',
        'Frypan',
        'Head Butt',
        'Sudden Lunge',
        'Sweeping Gouge',
        'Tail Slap',
        'Whirl of Rage'}

    -- MAGICAL MODIFIERS
    modifiers.MagicACC = S{
        '1000 Needles',
        'Absolute Terror',
        'Actinic Burst',
        'Auroral Drape',
        'Awful Eye',
        'Blank Gaze',
        'Blistering Roar',
        'Blitzstrahl',
        'Chaotic Eye',
        'Cimicine Discharge',
        'Cold Wave',
        'Corrosive Ooze',
        'Demoralizing Roar',
        'Dream Flower',
        'Enervation',
        'Feather Tickle',
        'Filamented Hold',
        'Frightful Roar',
        'Geist Wall',
        'Infrasonics',
        'Jettatura',
        'Light of Penance',
        'Lowing',
        'Mind Blast',
        'Mortal Ray',
        'Mysterious Light',
        'Polar Roar',
        'Reaving Wind',
        'Sandspin',
        'Sandspray',
        'Sheep Song',
        'Soporific',
        'Sound Blast',
        'Stinking Gas',
        'Temporal Shift',
        'Tourbillion',
        'Venom Shell',
        'Voracious Trunk',
        'Yawn'}
    modifiers.Nuke = S{
        'Acrid Stream',
        'Anvil Lightning',
        'Blastbomb',
        'Blazing Bound',
        'Bomb Toss',
        'Charged Whisker',
        'Crashing Thunder',
        'Cursed Sphere',
        'Droning Whirlwind',
        'Embalming Earth',
        'Entomb',
        'Firespit',
        'Foul Waters',
        'Gates of Hades',
        'Ice Break',
        'Leafstorm',
        'Maelstrom',
        'Magic Hammer',
        'Molting Plumage',
        'Nectarous Deluge',
        'Regurgitation',
        'Rending Deluge',
        'Scouring Spate',
        'Searing Tempest',
        'Self-Destruct',
        'Silent Storm',
        'Spectral Floe',
        'Subduction',
        'Tempest Upheaval',
        'Thermal Pulse',
        'Thunderbolt',
        'Uproot',
        'Water Bomb'}
    modifiers.NukeDarkAff = S{
        'Blood Drain',
        'Blood Saber',
        'Dark Orb',
        'Death Ray',
        'Digest',
        'Evryone. Grudge',
        'Eyes On Me',
        'MP Drainkiss',
        'Osmosis',
        'Palling Salvo',
        'Tenebral Crush'}
    modifiers.NukeLightAff = S{
        'Blinding Fulgor',
        'Diffusion Ray',
        'Rail Cannon',
        'Retinal Glare'}
    modifiers.Breath = S{
        'Bad Breath',
        'Flying Hip Press',
        'Frost Breath',
        'Heat Breath',
        'Hecatomb Wave',
        'Magnetite Cloud',
        'Poison Breath',
        'Radiant Breath',
        'Thunder Breath',
        'Vapor Spray',
        'Wind Breath'}
    modifiers.Skill = S{
        'Barrier Tusk',
        'Diamondhide',
        'Magic Barrier',
        'Metallic Body',
        'Occultation',
        'Plasma Charge',
        'Pyric Bulwark',
        'Reactor Cool'}
    modifiers.SkillDarkAff = S{
        'Atra. Libations'}
    modifiers.Healing = S{
        'Healing Breeze',
        'Magic Fruit',
        'Plenilune Embrace',
        'Pollen',
        'Restoral',
        'Wild Carrot'}
    modifiers.HealingMAXHP = S{
        'White Wind'}
    modifiers.Recast = S{
        'Amplification',
        'Animating Wail',
        'Battery Charge',
        'Carcharian Verve',
        'Cocoon',
        'Erratic Flutter',
        'Exuviation',
        'Fantod',
        'Feather Barrier',
        'Harden Shell',
        'Memento Mori',
        'Nat. Meditation',
        'Orcish Counterstance',
        'Refueling',
        'Regeneration',
        'Saline Coat',
        'Triumphant Roar',
        'Warm-Up',
        'Winds of Promy.',
        'Zephyr Mantle'}

    physical = S{
        'STR',
        'DEX',
        'VIT',
        'AGI',
        'INT',
        'MND',
        'CHR',
        'PhysACC',
        'PhysMagicACC'}
    magical = S{
        'MagicACC',
        'Nuke',
        'NukeDarkAff',
        'NukeLightAff',
        'Breath',
        'Skill',
        'SkillDarkAff',
        'Healing',
        'HealingMAXHP',
        'Recast'}
end

function check_buffs(...)
    --[[ Function Author: Arcon
            Simple check before attempting to auto activate Job Abilities that
            check active buffs and debuffs ]]
    return table.any({...}, table.get+{buffactive})
end

function check_set_spells(...)
    --[[ Function Author: Arcon
            Used to pull list of currently set spells, this is useful for
            determining traits such as Dual Wield IV
            Also used to determine the Cure spell set, when used with a
            self_command ]]
    set_spells = set_spells
        or gearswap.res.spells:type('BlueMagic'):rekey('name')
        return table.all({...}, function(name)
        return S(windower.ffxi.get_mjob_data().spells)
        :contains(set_spells[name].id)
    end)
end

do
    --[[ Author: Arcon
            The three next "do" sections are used to aid in checking recast
            times, can check multiple recast times at once ]]
    local cache = {}

    function j(str)
        if not cache[str] then
            cache[str] = gearswap.res.job_abilities:with('name', str)
        end

        return cache[str]
    end
end

do
    local cache = {}

    function s(str)
        if not cache[str] then
            cache[str] = gearswap.res.spells:with('name', str)
        end

        return cache[str]
    end
end

do
    local ja_types = S(gearswap.res.job_abilities:map(table.get-{'type'}))

    function check_recasts(...)
        local spells = S{...}

        for spell in spells:it() do
            local fn = 'get_' .. (ja_types:contains(spell.type)
                    and 'ability'
                    or 'spell') ..'_recasts'
            if windower.ffxi[fn]()[spell.recast_id] > 0 then
                return false
            end
        end

        return true
    end
end

function self_command(str)
    -- Use an in game macro "/con gs c auto_action" to toggle bot Off and On
    if str == 'auto_action' then
        if auto_action == 'Off' then
            auto_action = 'On'
        else
            auto_action  = 'Off'
        end
        windower.add_to_chat(8,'Auto fire event set to: '..auto_action)

    --[[ Use an in game macro "/con gs c cure" to dynamically use currently set
            cure spell
            The list below is limited to the most used spells, can expand list
            as needed
            Please be aware if multiple cures are set the first one listed will
            be the one used so plan accordingly ]]
    elseif str == 'cure' then
        if check_set_spells('Magic Fruit') then
            if party.count > 1 then
                windower.send_command('input /ma "Magic Fruit" <stpc>')
            else
                windower.send_command('input /ma "Magic Fruit" <me>')
            end
        elseif check_set_spells('Plenilune Embrace') then
            if party.count > 1 then
                windower.send_command('input /ma "Plenilune Embrace" <stpc>')
            else
                windower.send_command('plenilune embrace')
            end
        elseif check_set_spells('Restoral') then
            windower.send_command('restoral')
        elseif check_set_spells('White Wind') then
            windower.send_command('white wind')
        else
            if player.sub_job == 'RDM' then
                 if party.count > 1 then
                    windower.send_command('input /ma "Cure IV" <stpc>')
                else
                    windower.send_command('input /ma "Cure IV" <me>')
                end
            else
                windower.add_to_chat(8,'WARNING: No Cure spell is'
                    ..' currently set!')
            end
        end

    -- Use an in game macro "/con gs c dt_mode" to toggle Damage Taken set
    elseif str == 'dt_mode' then
        if dt_mode == 'None' then
            dt_mode = 'Active'
        else
            dt_mode = 'None'
        end
        windower.add_to_chat(8,'Damage taken set to: '..dt_mode)
        gear_modes()

    -- Use an in game macro "/con gs c tp_mode"
    -- to cycle between Normal and Accuracy sets
    elseif str == 'tp_mode' then
        if tp_mode == 'Normal' then
            tp_mode = 'Accuracy Mid'
        elseif tp_mode == 'Accuracy Mid' then
            tp_mode = 'Accuracy High'
        else
            tp_mode = 'Normal'
        end
        windower.add_to_chat(8,'Engaged melee set mode: '..tp_mode)
        gear_modes()

    -- Will call function when F10 in pressed, initial bind is performed near
    -- the top of this file
    elseif str == 'tryweaponskill' then
        try_weaponskill()

    -- Use an in game macro "/con gs c weapon_combo" to set weapon preference,
    -- Swords or Clubs. Useful when enemy uses TP move to remove them
    elseif str == 'weapon_combo' then
        if weapon_combo == 'Iris' then
            weapon_combo = 'Iris'
        else
            weapon_combo = 'Soluis'
        end
        windower.add_to_chat(8,'Weapon type set to: '..weapon_combo)
    end
end

function gear_modes()
    -- User created bridge for aftercast and status_change functions
    -- Sequential gear sets used to easily allow for changing player needs
    slot_disabling()

    local attack_speed = 'Magic Haste Uncapped'

    if player.status == 'Engaged' then
        --[[ This will adjust the amount of Dual Wield used based on if Magic
                Haste is capped from March song, It is assumed that March is
                sung with an instrument that will allow you to hit the cap ]]
        if check_buffs('Haste') and check_buffs('March') then
            attack_speed = 'Magic Haste Capped'
        else
            attack_speed = 'Magic Haste Uncapped'
        end
        equip(sets.TP[attack_speed][tp_mode], sets.misc.DT[dt_mode])
    elseif player.status == 'Idle' then
        equip(sets.idle, sets.misc.DT[dt_mode], sets.misc.Movement)
        if dt_mode == 'None' then
            if party.count > 1 and dt_mode == 'None' then
                equip(sets.idle.SphereRefresh)
            end
            if player.mpp < 50 then
                equip(sets.idle.under_50mpp)
            end
            if check_buffs('Reive Mark') then
                equip(sets.misc.Reive)
            end
        end
    end

   -- Will inform you if no weapon is equiped and re-equip once able
    if player.equipment.main == 'empty' then
        equip(sets.weapon[weapon_combo])
        windower.add_to_chat(8,'No Weapon, trying to re-equip: '..weapon_combo)
    end
end

function relaxed_play_mode()
    -- This can be used as a mini bot to automate actions
    if not midaction() then
        if player.hpp < 50
                and not check_buffs('silence', 'mute')
                and check_recasts(s('White Wind')) then
            windower.send_command('white wind')

        elseif player.target.hpp < 40
                and player.target.hpp > 15
                and not check_buffs('silence', 'mute')
                and player.target.distance < 5 then
            windower.send_command('sinker drill')

        elseif not check_buffs('Haste')
                and not check_buffs('silence', 'mute')
                and check_recasts(s('Erratic Flutter')) then
            windower.send_command('erratic flutter')

        elseif not check_buffs('Attack Boost')
                and not check_buffs('silence', 'mute')
                and check_recasts(s('Nat. Meditation')) then
            windower.send_command('nat. meditation')

        elseif player.equipment.main == 'Tizona'
                and not check_buffs('Aftermath: Lv.3')
                and player.tp < 3000 then
            return

        elseif player.equipment.main == 'Tizona'
                and not check_buffs('Aftermath: Lv.3')
                and player.target.hpp > 40
                and player.tp == 3000 then
            windower.send_command('expiacion')

        elseif player.tp > 999
                and player.target.hpp > 40
                and player.target.distance < 5 then
            windower.send_command('chant du cygne')
        end
    end
end

function try_weaponskill()
    --[[ F10 bind:
            One button press has the ability to perform one of three
            Weaponskills:
            Chant du Cygne will change to Expiacion when AM3 is down and at
            3000 TP and will hold TP if over 2000 but below 3000
            A Club in main hand it will change to Realmrazer,
            If Idle and F10 is pressed you will change to current Idle/DT set,
            useful as a fast way to equip proper gear ]]
    if player.status == 'Engaged' then
        if player.equipment.main == 'Tizona' then
            if player.tp == 3000 and not check_buffs('Aftermath: Lv.3') then
                windower.send_command('expiacion')
            elseif player.tp > 2000 and not check_buffs('Aftermath: Lv.3') then
                windower.add_to_chat(8,'Holding TP til 3000'
                    ..' to gain Aftermath: Lv.3')
                return
            else
                windower.send_command('chant du cygne')
            end
        else
            windower.send_command('chant du cygne')
        end
    else
        gear_modes()
    end
end

function slot_disabling()
    -- Disable slots for items you don't want removed when performing actions
    if player.equipment.head == 'Reraise Hairpin' then
        disable('head')
        windower.add_to_chat(8,'Reraise Hairpin equiped on head')
    else
        enable('head')
    end

    if player.equipment.left_ear == 'Reraise Earring' then
        disable('left_ear')
        windower.add_to_chat(8,'Reraise Earring equiped on left ear')
    else
        enable('left_ear')
    end

    if player.equipment.right_ear == 'Reraise Earring' then
        disable('right_ear')
        windower.add_to_chat(8,'Reraise Earring equiped on right ear')
    else
        enable('right_ear')
    end

    --[[ count_msg_mecisto can be adjusted to the value you want for periodic
            reminders that you have slot locked, count is incresed twice by
            most actions due to slot_disabling() being called in precast
            and again after the cast in gear_modes() ]]
    if player.equipment.back == 'Mecisto. Mantle' then
        disable('back')
        if count_msg_mecisto == 0 then
            windower.add_to_chat(8,'REMINDER:  '
                ..'Mecistopins mantle equiped on back')
        end
        count_msg_mecisto = (count_msg_mecisto + 1) % 30
    else
        enable('back')
        count_msg_mecisto = 0
    end
end

function status_change(new,old)
    if T{'Idle','Engaged'}:contains(new) and gear_change_ok then
        gear_modes()
    end
end

function buff_change(buff,gain)
    -- When encumbrance wears off will re-equip current gear set
    if buff == 'encumbrance' and not gain then
        gear_modes()

    -- TIMERS PLUGIN: Create and delete custom timers for aftermath levels
    elseif player.equipment.main == 'Tizona'
            and buff:startswith('Aftermath') then
        if gain then
            windower.send_command('timers c "'..buff..'" '..mythic_aftermath_times[buff]..' down abilities/00027.png')
        else
            windower.send_command('timers d "'..buff..'"')
        end

    -- TIMERS PLUGIN: Primeval Brew (Transcendency)
    elseif buff == 'Transcendency' then
        if gain then
            windower.send_command('timers c "Transcendency" 180'..'down abilities/00018.png')
        else
            windower.send_command('timers d "Transcendency"')
        end

    -- TIMERS PLUGIN: Weakness
    elseif buff == 'weakness' then
        if gain then
            windower.send_command('timers c "Weakness" 300 down'..'abilities/00255.png')
        else
            windower.send_command('timers d "Weakness"')
        end
    end
end

function precast(spell,arg)
    gear_change_ok = false
    slot_disabling()

    -- Automates Berserk/Warcry for Warrior sub job
    if berserk_warcry_automation:contains(spell.name)
            and player.status == 'Engaged'
            and player.sub_job == 'WAR'
            and check_recasts(j('Berserk'))
            and not check_buffs(
                'Amnesia',
                'Berserk',
                'Obliviscence',
                'Paralysis') then
        windower.send_command('berserk; wait 1; warcry; wait 1;'..spell.name..' '..spell.target.raw)
        cancel_spell()
        return
    end

    --[[ Generic equip command for Job Abilities and Weaponskills that have
            a gear set listed in get_sets()
            If Idle and a weaponskill macro is pressed you will change to
            current Idle/DT set, useful as a fast way to equip proper gear
            For then in game macros the quotations("") and <t> aren't needed
            EX: /ws Expiacion ]]
    if sets.precast.JA[spell.name] then
        equip(sets.precast.JA[spell.name])
    elseif sets.precast.WS[spell.name] then
        if player.status == 'Engaged' then
            equip(sets.precast.WS[spell.name])
            if check_buffs('Reive Mark') then
                equip(sets.misc.Reive)
            end
        else
            cancel_spell()
            gear_modes()
            return
        end
    end

    -- Magic spell gear handling(Precast)
    if spell.prefix == '/magic'
            or spell.prefix == '/ninjutsu'
            or spell.prefix == '/song' then
        if spell.type == 'BlueMagic' then
            equip(sets.precast.FastCast.BlueMagic)
        else
            equip(sets.precast.FastCast)
        end
        if spell.name == 'Utsusemi: Ichi'
                and check_recasts(spell)
                and shadow_type == 'Ni' then
            if check_buffs(
                    'Copy Image',
                    'Copy Image (2)',
                    'Copy Image (3)') then
                windower.send_command('cancel copy image;'
                    ..'cancel copy image (2); cancel copy image (3)')
            end
        elseif (spell.name == 'Monomi: Ichi' or spell.name == 'Sneak')
                and check_buffs('Sneak')
                and check_recasts(spell)
                and spell.target.type == 'SELF' then
            windower.send_command('cancel sneak')
        elseif (spell.name == 'Diamondhide'
                or spell.name == 'Metallic body'
                or spell.name == 'Stoneskin')
                and check_buffs('Stoneskin')
                and check_recasts(spell) then
            windower.send_command('cancel stoneskin')
        end
    end

    -- Dancer Sub Job
    if spell.name == 'Spectral Jig'
            and check_buffs('Sneak')
            and check_recasts(spell) then
        windower.send_command('cancel sneak')
        cast_delay(0.3)
    elseif windower.wc_match(spell.name,'*Step') then
        equip(sets.TP['Accuracy High'])
    end
	
	if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        equip(sets.precast.LuzafRing)
	end
	
end

function midcast(spell,arg)
    -- Special handling for Spell Mappings outlined in get_maps()
    local stat
    for key, set in pairs(modifiers) do
        if set:contains(spell.name) then
            stat = key
        end
    end

    local physical = stat and physical:contains(stat)
    local magical = stat and magical:contains(stat)

    -- Magic spell gear handling(Midcast)
    if physical then
        equip(sets.midcast.BlueMagic[stat])
        if check_buffs('Chain Affinity') then
            equip(sets.misc['Chain Affinity'])
        end
        if check_buffs('Efflux') then
            equip(sets.misc.Efflux)
        end
        if tp_mode == 'Accuracy High' and stat ~= 'PhysMagicACC' then
            equip(sets.midcast.BlueMagic.PhysACC)
        end
    elseif magical then
        equip(sets.midcast.BlueMagic[stat])
        if stat == 'Healing' and spell.target.type == 'SELF' then
            equip(sets.midcast.BlueMagic.Healing.Self)
        elseif stat == 'Nuke' then
            if spell.element == world.day_element or spell.element == world.weather_element then
                equip(sets.misc.Obi)
            end
        elseif check_buffs('Diffusion') then
            equip(sets.misc.Diffusion)
        end
    end

    if spell.skill == 'Healing Magic' or spell.skill == 'Enhancing Magic' or spell.type == 'Trust' then
        equip(sets.midcast.BlueMagic.Recast)
        if spell.name:startswith('Cure') then
            equip(sets.midcast.BlueMagic.Healing)
            if spell.target.type == 'SELF' then
                equip(sets.midcast.BlueMagic.Healing.Self)
            end
        end
    elseif spell.skill == 'Elemental Magic' then
        equip(sets.midcast.BlueMagic.Nuke)
    end

    if spell.name:startswith('Utsusemi') then
        equip(sets.misc.DT.Active)
    end
end

function aftercast(spell,arg)
    gear_change_ok = true
    gear_modes()

    -- Gear info, useful if using DressUp or BlinkMeNot
    if dt_mode ~= 'None' or tp_mode ~= 'Normal' then
        windower.add_to_chat(8,player.name..': Melee = '..tp_mode..'  |  Damage Taken = '..dt_mode)
    end

    if not spell.interrupted then
        -- Changes shadow type variable to allow cancel Copy Image
        -- if last cast was Utsusemi: Ni
        if spell.name == 'Utsusemi: Ni' then
            shadow_type = 'Ni'
        elseif spell.name == 'Utsusemi: Ichi' then
            shadow_type = 'Ichi'
        end

        -- TIMERS PLUGIN: Dream Flower
        if spell.name == 'Dream Flower' then
            windower.add_to_chat(8,'NOTE: 1:30 general timer set, '
                ..'max sleep can last 2:00')
            windower.send_command('timers c "Dream Flower" 90 down'
                ..'spells/00521.png')
        end

        -- TIMERS PLUGIN: Since Aftermath: Lv.1 can overwrite itself this
        -- will delete and re-create this specific timer
        if spell.name == 'Expiacion' and player.equipment.main == 'Tizona' and check_buffs('Aftermath: Lv.1') then
            windower.send_command('timers d "Aftermath: Lv.1"; wait 0.3;'..'timers c "Aftermath: Lv.1" 90 down abilities/00027.png')
        end
    end
end