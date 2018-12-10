local Utility = require("Utility")


local Abaddon = {}

optionEnableScript = Menu.AddOption({"Hero by Rasta", "Abaddon"}, "1.Enable", "Turn on/off this script.")
PressComboKey = Menu.AddKeyOption({ "Hero by Rasta","Abaddon" }, "2. Execute combo key", Enum.ButtonCode.KEY_I)
Abaddon.AddBKB = Menu.AddOption({"Hero by Rasta", "Abaddon"}, "BKB", "Use BKB on combo")
local optionAutoSave = Menu.AddOption({"Hero by Rasta", "Abaddon"}, "Auto Save", "Auto cast 'Aphotic Shield' to save needed ally")
local optionKillSteal = Menu.AddOption({"Hero by Rasta", "Abaddon"}, "Kill Steal", "Auto cast 'Mist Coil' to KS")
local optionAwareness = Menu.AddOption({"Hero by Rasta", "Abaddon"}, "Awareness", "Show how many hits left to kill enemy")
local font = Renderer.LoadFont("Tahoma", 30, Enum.FontWeight.EXTRABOLD)
Abaddon.npcName = "npc_dota_hero_abaddon"

function Abaddon.OnUpdate()
    local myHero = Heroes.GetLocal()
    if not myHero then return end
    if not Utility.IsSuitableToCastSpell(myHero) then return end
    if NPC.GetUnitName(myHero) ~= Abaddon.npcName then return end
	
    if Menu.IsEnabled(optionAutoSave) then
        Abaddon.AutoSave(myHero)
    end

    if Menu.IsEnabled(optionKillSteal) then
        Abaddon.KillSteal(myHero)
    end
	
	if not Menu.IsEnabled(optionEnableScript) then return true end
	
		if Menu.IsKeyDown(PressComboKey) then	
		-- Skills
		local aphoticshield = NPC.GetAbility(myHero, "abaddon_aphotic_shield")
		local mistcoil = NPC.GetAbility(myHero, "abaddon_death_coil")  
	
		
		-- Items
        local shivas = NPC.GetItem(myHero, "item_shivas_guard", true)
        local mjolnir = NPC.GetItem(myHero, "item_mjollnir", true)
        local manta = NPC.GetItem(myHero, "item_manta", true)
        local atos = NPC.GetItem(myHero, "item_rod_of_atos", true)
        local MoM = NPC.GetItem(myHero, "item_mask_of_madness", true)
        local necronomicon1 = NPC.GetItem(myHero, "item_necronomicon", true)
        local necronomicon2 = NPC.GetItem(myHero, "item_necronomicon_2", true)
        local necronomicon3 = NPC.GetItem(myHero, "item_necronomicon_3", true)
        local discord = NPC.GetItem(myHero, "item_veil_of_discord", true)
		local lotus = NPC.GetItem(myHero, "item_lotus_orb", true)
		local BKB = NPC.GetItem(myHero, "item_black_king_bar", true)
		local blademail = NPC.GetItem(myHero, "item_blade_mail", true)
		local diffusal = NPC.GetItem(myHero, "item_diffusal_blade", true)
		local nullifier = NPC.GetItem(myHero, "item_nullifier", true)
		local medallion = NPC.GetItem(myHero, "item_medallion_of_courage", true)
		local solarCrest = NPC.GetItem(myHero, "item_solar_crest", true)
		local aghanimScepter = NPC.GetItem(myHero, "item_ultimate_scepter", true)
		local orchid = NPC.GetItem(myHero, "item_orchid", true)
		local bloodthorn = NPC.GetItem(myHero, "item_bloodthorn", true)
		local abyssalblade = NPC.GetItem(myHero, "item_abyssal_blade", true)
		local forceStaff = NPC.GetItem(myHero, "item_force_staff", true)
		local hurricanePike = NPC.GetItem(myHero, "item_hurricane_pike", true)
		local eul = NPC.GetItem(myHero, "item_cyclone", true)
		local Blink = NPC.GetItem(myHero, "item_blink", true)
		
		local myMana = NPC.GetMana(myHero)
		local enemyTarget = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
		
		if enemyTarget and NPC.HasModifier(enemyTarget, "modifier_item_ultimate_scepter") and Ability.IsReady(NPC.GetAbility(enemyTarget, "antimage_spell_shield")) then
			

			if diffusal and Ability.IsReady(diffusal) and Ability.IsCastable(diffusal, myMana) then
				Ability.CastTarget(diffusal, enemyTarget) 
			return end
			
			return 
		end
		
		if enemyTarget and NPC.IsLinkensProtected(enemyTarget) then
			if forceStaff and Ability.IsReady(forceStaff) and Ability.IsCastable(forceStaff, myMana) then
				Ability.CastTarget(forceStaff, enemyTarget) 
			return end
			
			if hurricanePike and Ability.IsReady(hurricanePike) and Ability.IsCastable(hurricanePike, myMana) then
				Ability.CastTarget(hurricanePike, enemyTarget) 
			return end
			
			if eul and Ability.IsReady(eul) and Ability.IsCastable(eul, myMana) then
				Ability.CastTarget(eul, enemyTarget) 
			return end
			
			if diffusal and Ability.IsReady(diffusal) and Ability.IsCastable(diffusal, myMana) then
				Ability.CastTarget(diffusal, enemyTarget) 
			return end
			
			if abyssalblade and Ability.IsReady(abyssalblade) and Ability.IsCastable(abyssalblade, myMana) then
				Ability.CastTarget(abyssalblade, enemyTarget) 
			return end
			
			if orchid and Ability.IsReady(orchid) and Ability.IsCastable(orchid, myMana) then
				Ability.CastTarget(orchid, enemyTarget) 
			return end
		
			if bloodthorn and Ability.IsReady(bloodthorn) and Ability.IsCastable(bloodthorn, myMana) then
				Ability.CastTarget(bloodthorn, enemyTarget) 
			return end
			
			return 
		end
		
		if Blink and Ability.IsCastable(Blink, myMana) and enemyTarget ~= nil and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemyTarget),1200,0) then 
		local enemyAbsOrigin = Entity.GetAbsOrigin(enemyTarget)
		Ability.CastPosition(Blink,enemyAbsOrigin) 
		return end
		
		if enemyTarget and Menu.IsEnabled(Abaddon.AddBKB) and Ability.IsReady(BKB) and Ability.IsCastable(BKB, myMana) then
			Ability.CastNoTarget(BKB) 
		return end
		
		if enemyTarget and shivas and Ability.IsReady(shivas) and Ability.IsCastable(shivas, myMana) then
			Ability.CastNoTarget(shivas) 
		return end
		
		if enemyTarget and mjolnir and Ability.IsReady(mjolnir) and Ability.IsCastable(mjolnir, myMana) then
			Ability.CastTarget(mjolnir, myHero) 
		return end

		if enemyTarget and atos and Ability.IsReady(atos) and Ability.IsCastable(atos, myMana) then
			Ability.CastTarget(atos, enemyTarget) 
		return end

		if enemyTarget and necronomicon1 and Ability.IsReady(necronomicon1) and Ability.IsCastable(necronomicon1, myMana) then
			Ability.CastNoTarget(necronomicon1) 
		return end

		if enemyTarget and necronomicon2 and Ability.IsReady(necronomicon2) and Ability.IsCastable(necronomicon2, myMana) then
			Ability.CastNoTarget(necronomicon2) 
		return end

		if enemyTarget and necronomicon3 and Ability.IsReady(necronomicon3) and Ability.IsCastable(necronomicon3, myMana) then
			Ability.CastNoTarget(necronomicon3) 
		return end

		if discord and Ability.IsCastable(discord, myMana) and enemyTarget ~= nil and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemyTarget),1200,0) then 
		local enemyAbsOrigin = Entity.GetAbsOrigin(enemyTarget)
		Ability.CastPosition(discord,enemyAbsOrigin) 
		return end

		if enemyTarget and manta and Ability.IsReady(manta) and Ability.IsCastable(manta, myMana) then
			Ability.CastNoTarget(manta) 
		return end

		if enemyTarget and lotus and Ability.IsReady(lotus) and Ability.IsCastable(lotus, myMana) then
			Ability.CastTarget(lotus, myHero) 
		return end
		
		if enemyTarget and stomp and Ability.IsReady(stomp) and Ability.IsCastable(stomp, myMana) then
			Ability.CastNoTarget(stomp)
		return end
		
		if enemyTarget and edge and Ability.IsReady(edge) and Ability.IsCastable(edge, myMana) then 
			Ability.CastTarget(edge, enemyTarget) 
		return end
		
		
		if enemyTarget and abyssalblade and Ability.IsReady(abyssalblade) and Ability.IsCastable(abyssalblade, myMana) then
			Ability.CastTarget(abyssalblade, enemyTarget) 
		return end
		
		if enemyTarget and diffusal and Ability.IsReady(diffusal) and Ability.IsCastable(diffusal, myMana) then
			Ability.CastTarget(diffusal, enemyTarget) 
		return end
		
		if enemyTarget and blademail and Ability.IsReady(blademail) and Ability.IsCastable(blademail, myMana) then
			Ability.CastNoTarget(blademail) 
		return end
		
		if enemyTarget and medallion and Ability.IsReady(medallion) and Ability.IsCastable(medallion, myMana) then
			Ability.CastTarget(medallion, enemyTarget) 
		return end
		
		if enemyTarget and solarCrest and Ability.IsReady(solarCrest) and Ability.IsCastable(solarCrest, myMana) then
			Ability.CastTarget(solarCrest, enemyTarget) 
		return end
		
		if enemyTarget and orchid and Ability.IsReady(orchid) and Ability.IsCastable(orchid, myMana) then
			Ability.CastTarget(orchid, enemyTarget) 
		return end
		
		if enemyTarget and bloodthorn and Ability.IsReady(bloodthorn) and Ability.IsCastable(bloodthorn, myMana) then
			Ability.CastTarget(bloodthorn, enemyTarget) 
		return end
		
		if enemyTarget and nullifier and Ability.IsReady(nullifier) and Ability.IsCastable(nullifier, myMana) then
			Ability.CastTarget(nullifier, enemyTarget) 
		return end
		
		if enemyTarget and MoM and Ability.IsReady(MoM) and Ability.IsCastable(MoM, myMana) then
			Ability.CastNoTarget(MoM) 
		return end
				
	end
	
end

function Abaddon.OnDraw()
	if not Menu.IsEnabled(optionAwareness) then return end

    local myHero = Heroes.GetLocal()
    if not myHero or NPC.GetUnitName(myHero) ~= "npc_dota_hero_abaddon" then return end

    local coil_damage = 0
    local coil = NPC.GetAbility(myHero, "abaddon_death_coil")
    if coil and Ability.IsCastable(coil, NPC.GetMana(myHero)) then
        coil_damage = 50 + 50 * Ability.GetLevel(coil)
    end

    for i = 1, Heroes.Count() do
        local enemy = Heroes.Get(i)
        if not NPC.IsIllusion(enemy) and not Entity.IsSameTeam(myHero, enemy) and not Entity.IsDormant(enemy) and Entity.IsAlive(enemy) then
            
            local enemyHp = Entity.GetHealth(enemy)
            local physical_damage = NPC.GetTrueDamage(myHero) * NPC.GetArmorDamageMultiplier(enemy) 
            local magical_damage = coil_damage * NPC.GetMagicalArmorDamageMultiplier(enemy)
            local enemyHpLeft = enemyHp - magical_damage
            local hitsLeft = math.ceil(enemyHpLeft / math.max(physical_damage, 1))
            
            -- draw
            local pos = Entity.GetAbsOrigin(enemy)
            local x, y, visible = Renderer.WorldToScreen(pos)

              -- red : can kill; green : cant kill
            if enemyHpLeft <= 0 then
                Renderer.SetDrawColor(255, 0, 0, 255)
                Renderer.DrawTextCentered(font, x, y, "Kill", 1)
            else
                Renderer.SetDrawColor(0, 255, 0, 255)
                Renderer.DrawTextCentered(font, x, y, hitsLeft, 1)
            end
        end
	end
end

function Abaddon.AutoSave(myHero)
    local shield = NPC.GetAbility(myHero, "abaddon_aphotic_shield")
    if not shield or not Ability.IsCastable(shield, NPC.GetMana(myHero)) then return end

    if Utility.NeedToBeSaved(myHero) and Utility.CanCastSpellOn(myHero) then
        Ability.CastTarget(shield, myHero)
        return
    end

    local range = 500
    local allies = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_FRIEND)
    for i, ally in ipairs(allies) do
	    if Utility.NeedToBeSaved(ally) and Utility.CanCastSpellOn(ally) then
	        Ability.CastTarget(shield, ally)
	        return
	    end
    end
end

function Abaddon.KillSteal(myHero)
    local coil = NPC.GetAbility(myHero, "abaddon_death_coil")
    if not coil or not Ability.IsCastable(coil, NPC.GetMana(myHero)) then return end
    local damage = 50 + 50 * Ability.GetLevel(coil)

    local range = 800
    local enemies = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)
    if not enemies or #enemies <= 0 then return end

    for i, enemy in ipairs(enemies) do
    	local true_damage = damage * NPC.GetMagicalArmorDamageMultiplier(enemy)
	    if Entity.GetHealth(enemy) <= true_damage and Utility.CanCastSpellOn(enemy) then
	        Ability.CastTarget(coil, enemy)
	        return
	    end
    end
end

return Abaddon