-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Entitys = {}
local WalkMode = nil
local EntityModel = ""
local isRunning = false
local isShooting = false
local EntityZombie = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD NPC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		SetRandomBoats(0)
		SetGarbageTrucks(0)
		SetPedDensityMultiplierThisFrame(0.0)
		SetVehicleDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0,0.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Models = {
	"A_F_M_Beach_01",
	"A_F_M_BevHills_01",
	"A_F_M_BevHills_02",
	"A_F_M_BodyBuild_01",
	"A_F_M_Business_02",
	"A_F_M_Downtown_01",
	"A_F_M_EastSA_01",
	"A_F_M_EastSA_02",
	"A_F_M_FatBla_01",
	"A_F_M_FatCult_01",
	"A_F_M_FatWhite_01",
	"A_F_M_KTown_01",
	"A_F_M_KTown_02",
	"A_F_M_ProlHost_01",
	"A_F_M_Salton_01",
	"A_F_M_SkidRow_01",
	"A_F_M_SouCentMC_01",
	"A_F_M_SouCent_01",
	"A_F_M_SouCent_02",
	"A_F_M_Tourist_01",
	"A_F_M_TrampBeac_01",
	"A_F_M_Tramp_01",
	"A_F_O_GenStreet_01",
	"A_F_O_Indian_01",
	"A_F_O_KTown_01",
	"A_F_O_Salton_01",
	"A_F_O_SouCent_01",
	"A_F_O_SouCent_02",
	"A_F_Y_Beach_01",
	"A_F_Y_BevHills_01",
	"A_F_Y_BevHills_02",
	"A_F_Y_BevHills_03",
	"A_F_Y_BevHills_04",
	"A_F_Y_Business_01",
	"A_F_Y_Business_02",
	"A_F_Y_Business_03",
	"A_F_Y_Business_04",
	"A_F_Y_EastSA_01",
	"A_F_Y_EastSA_02",
	"A_F_Y_EastSA_03",
	"A_F_Y_Epsilon_01",
	"A_F_Y_Fitness_01",
	"A_F_Y_Fitness_02",
	"A_F_Y_GenHot_01",
	"A_F_Y_Golfer_01",
	"A_F_Y_Hiker_01",
	"A_F_Y_Hippie_01",
	"A_F_Y_Hipster_01",
	"A_F_Y_Hipster_02",
	"A_F_Y_Hipster_03",
	"A_F_Y_Hipster_04",
	"A_F_Y_Indian_01",
	"A_F_Y_Juggalo_01",
	"A_F_Y_Runner_01",
	"A_F_Y_RurMeth_01",
	"A_F_Y_SCDressy_01",
	"A_F_Y_Skater_01",
	"A_F_Y_SouCent_01",
	"A_F_Y_SouCent_02",
	"A_F_Y_SouCent_03",
	"A_F_Y_Tennis_01",
	"A_F_Y_Topless_01",
	"A_F_Y_Tourist_01",
	"A_F_Y_Tourist_02",
	"A_F_Y_Vinewood_01",
	"A_F_Y_Vinewood_02",
	"A_F_Y_Vinewood_03",
	"A_F_Y_Vinewood_04",
	"A_F_Y_Yoga_01",
	"A_M_M_AfriAmer_01",
	"A_M_M_Beach_01",
	"A_M_M_Beach_02",
	"A_M_M_BevHills_01",
	"A_M_M_BevHills_02",
	"A_M_M_Business_01",
	"A_M_M_EastSA_01",
	"A_M_M_EastSA_02",
	"A_M_M_Farmer_01",
	"A_M_M_FatLatin_01",
	"A_M_M_GenFat_01",
	"A_M_M_GenFat_02",
	"A_M_M_Golfer_01",
	"A_M_M_HasJew_01",
	"A_M_M_Hillbilly_01",
	"A_M_M_Hillbilly_02",
	"A_M_M_Indian_01",
	"A_M_M_KTown_01",
	"A_M_M_Malibu_01",
	"A_M_M_MexCntry_01",
	"A_M_M_MexLabor_01",
	"A_M_M_OG_Boss_01",
	"A_M_M_Paparazzi_01",
	"A_M_M_Polynesian_01",
	"A_M_M_ProlHost_01",
	"A_M_M_RurMeth_01",
	"A_M_M_Salton_01",
	"A_M_M_Salton_02",
	"A_M_M_Salton_03",
	"A_M_M_Salton_04",
	"A_M_M_Skater_01",
	"A_M_M_Skidrow_01",
	"A_M_M_SoCenLat_01",
	"A_M_M_SouCent_01",
	"A_M_M_SouCent_02",
	"A_M_M_SouCent_03",
	"A_M_M_SouCent_04",
	"A_M_M_StLat_02",
	"A_M_M_Tennis_01",
	"A_M_M_Tourist_01",
	"A_M_M_TrampBeac_01",
	"A_M_M_Tramp_01",
	"A_M_M_TranVest_01",
	"A_M_M_TranVest_02",
	"A_M_O_ACult_01",
	"A_M_O_ACult_02",
	"A_M_O_Beach_01",
	"A_M_O_GenStreet_01",
	"A_M_O_KTown_01",
	"A_M_O_Salton_01",
	"A_M_O_SouCent_01",
	"A_M_O_SouCent_02",
	"A_M_O_SouCent_03",
	"A_M_O_Tramp_01",
	"A_M_Y_ACult_02",
	"A_M_Y_BeachVesp_01",
	"A_M_Y_BeachVesp_02",
	"A_M_Y_Beach_01",
	"A_M_Y_Beach_02",
	"A_M_Y_Beach_03",
	"A_M_Y_BevHills_01",
	"A_M_Y_BevHills_02",
	"A_M_Y_BreakDance_01",
	"A_M_Y_BusiCas_01",
	"A_M_Y_Business_01",
	"A_M_Y_Business_02",
	"A_M_Y_Business_03",
	"A_M_Y_Cyclist_01",
	"A_M_Y_DHill_01",
	"A_M_Y_Downtown_01",
	"A_M_Y_EastSA_01",
	"A_M_Y_EastSA_02",
	"A_M_Y_Epsilon_01",
	"A_M_Y_Epsilon_02",
	"A_M_Y_Gay_01",
	"A_M_Y_Gay_02",
	"A_M_Y_GenStreet_01",
	"A_M_Y_GenStreet_02",
	"A_M_Y_Golfer_01",
	"A_M_Y_HasJew_01",
	"A_M_Y_Hiker_01",
	"A_M_Y_Hippy_01",
	"A_M_Y_Hipster_01",
	"A_M_Y_Hipster_02",
	"A_M_Y_Hipster_03",
	"A_M_Y_Indian_01",
	"A_M_Y_Jetski_01",
	"A_M_Y_Juggalo_01",
	"A_M_Y_KTown_01",
	"A_M_Y_KTown_02",
	"A_M_Y_Latino_01",
	"A_M_Y_MethHead_01",
	"A_M_Y_MexThug_01",
	"A_M_Y_MotoX_01",
	"A_M_Y_MotoX_02",
	"A_M_Y_MusclBeac_01",
	"A_M_Y_MusclBeac_02",
	"A_M_Y_Polynesian_01",
	"A_M_Y_RoadCyc_01",
	"A_M_Y_Runner_01",
	"A_M_Y_Runner_02",
	"A_M_Y_Salton_01",
	"A_M_Y_Skater_01",
	"A_M_Y_Skater_02",
	"A_M_Y_SouCent_01",
	"A_M_Y_SouCent_02",
	"A_M_Y_SouCent_03",
	"A_M_Y_SouCent_04",
	"A_M_Y_StBla_01",
	"A_M_Y_StBla_02",
	"A_M_Y_StLat_01",
	"A_M_Y_StWhi_01",
	"A_M_Y_StWhi_02",
	"A_M_Y_Sunbathe_01",
	"A_M_Y_Surfer_01",
	"A_M_Y_VinDouche_01",
	"A_M_Y_Vinewood_01",
	"A_M_Y_Vinewood_02",
	"A_M_Y_Vinewood_03",
	"A_M_Y_Vinewood_04",
	"A_M_Y_Yoga_01",
	"G_F_Y_ballas_01",
	"G_F_Y_Families_01",
	"G_F_Y_Lost_01",
	"G_F_Y_Vagos_01",
	"G_M_M_ArmBoss_01",
	"G_M_M_ArmGoon_01",
	"G_M_M_ArmLieut_01",
	"G_M_M_ChemWork_01",
	"G_M_M_ChiBoss_01",
	"G_M_M_ChiCold_01",
	"G_M_M_ChiGoon_01",
	"G_M_M_ChiGoon_02",
	"G_M_M_KorBoss_01",
	"G_M_M_MexBoss_01",
	"G_M_M_MexBoss_02",
	"G_M_Y_ArmGoon_02",
	"G_M_Y_Azteca_01",
	"G_M_Y_BallaEast_01",
	"G_M_Y_BallaOrig_01",
	"G_M_Y_BallaSout_01",
	"G_M_Y_FamCA_01",
	"G_M_Y_FamDNF_01",
	"G_M_Y_FamFor_01",
	"G_M_Y_Korean_01",
	"G_M_Y_Korean_02",
	"G_M_Y_KorLieut_01",
	"G_M_Y_Lost_01",
	"G_M_Y_Lost_02",
	"G_M_Y_Lost_03",
	"G_M_Y_MexGang_01",
	"G_M_Y_MexGoon_01",
	"G_M_Y_MexGoon_02",
	"G_M_Y_MexGoon_03",
	"G_M_Y_PoloGoon_01",
	"G_M_Y_PoloGoon_02",
	"G_M_Y_SalvaBoss_01",
	"G_M_Y_SalvaGoon_01",
	"G_M_Y_SalvaGoon_02",
	"G_M_Y_SalvaGoon_03",
	"G_M_Y_StrPunk_01",
	"G_M_Y_StrPunk_02",
	"IG_Abigail",
	"IG_Ashley",
	"IG_Bankman",
	"IG_Barry",
	"IG_BestMen",
	"IG_Beverly",
	"IG_Bride",
	"IG_Car3guy1",
	"IG_Car3guy2",
	"IG_Chef",
	"IG_ChengSr",
	"IG_ChrisFormage",
	"IG_Clay",
	"IG_ClayPain",
	"IG_Cletus",
	"IG_Dale",
	"IG_Dreyfuss",
	"IG_FBISuit_01",
	"IG_Groom",
	"IG_Hao",
	"IG_Hunter",
	"IG_Janet",
	"IG_JewelAss",
	"IG_JimmyBoston",
	"IG_JoeMinuteMan",
	"IG_Josef",
	"IG_Josh",
	"IG_KerryMcIntosh",
	"IG_LifeInvad_01",
	"IG_LifeInvad_02",
	"IG_Magenta",
	"IG_Manuel",
	"IG_Marnie",
	"IG_MaryAnn",
	"IG_Maude",
	"IG_Michelle",
	"IG_MrsPhillips",
	"IG_MRS_Thornhill",
	"IG_Natalia",
	"IG_Nigel",
	"IG_Old_Man1A",
	"IG_Old_Man2",
	"IG_ONeil",
	"IG_Ortega",
	"IG_Paper",
	"IG_Priest",
	"IG_ProlSec_02",
	"IG_Ramp_Gang",
	"IG_Ramp_Hic",
	"IG_Ramp_Hipster",
	"IG_Ramp_Mex",
	"IG_RoccoPelosi",
	"IG_RussianDrunk",
	"IG_Screen_Writer",
	"IG_Talina",
	"IG_Tanisha"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALKS
-----------------------------------------------------------------------------------------------------------------------------------------
local walks = {
	"move_m@drunk@verydrunk",
	"move_m@drunk@moderatedrunk",
	"move_m@drunk@a",
	"anim_group_move_ballistic",
	"move_lester_CaneUp",
}

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedShooting(ped) then
			isShooting = true
			SetTimeout(5000,function()
				isShooting = false
			end)
		end

		if IsPedSprinting(ped) or IsPedRunning(ped) then
	        if isRunning == false then
	            isRunning = true
	        end
	    else
	        if isRunning == true then
	            isRunning = false
	        end
	    end
		
		Citizen.Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if #Entitys < 10 then
			AddRelationshipGroup("zombie")
			SetRelationshipBetweenGroups(0,GetHashKey("zombie"),GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(2,GetHashKey("PLAYER"),GetHashKey("zombie"))
		
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local _,zPos = GetGroundZFor_3dCoord(coords["x"],coords["y"],coords["z"],true)

			EntityModel = Models[math.random(#Models)]
			EntityModel = GetHashKey(string.upper(EntityModel))
			RequestModel(EntityModel)
			while not HasModelLoaded(EntityModel) do
				Citizen.Wait(1)
			end

			local mathSize = math.random(-100,100)
			local spawnLocates = coords + mathSize
			local distanceSpawn = #(coords - spawnLocates)
			if distanceSpawn > 50 then
				EntityZombie = CreatePed(4,EntityModel,coords["x"] + mathSize,coords["y"] + mathSize,zPos,0.0,false,false)
				table.insert(Entitys,EntityZombie)

				WalkMode = walks[math.random(#walks)]			
				RequestAnimSet(WalkMode)
				while not HasAnimSetLoaded(WalkMode) do
					Citizen.Wait(1)
				end
	
				SetPedMovementClipset(EntityZombie,WalkMode,1.0)
				TaskWanderStandard(EntityZombie,1.0,10)
				SetCanAttackFriendly(EntityZombie,true,true)
				SetPedCanEvasiveDive(EntityZombie,false)
				SetPedRelationshipGroupHash(EntityZombie,GetHashKey("zombie"))
				SetPedCombatAbility(EntityZombie,0)
				SetPedCombatRange(EntityZombie,0)
				SetPedCombatMovement(EntityZombie,0)
				SetPedAlertness(EntityZombie,0)
				SetPedIsDrunk(EntityZombie,true)
				SetPedConfigFlag(EntityZombie,100,1)
				ApplyPedDamagePack(EntityZombie,"BigHitByVehicle",0.0,9.0)
				ApplyPedDamagePack(EntityZombie,"SCR_Dumpster",0.0,9.0)
				ApplyPedDamagePack(EntityZombie,"SCR_Torture",0.0,9.0)
				DisablePedPainAudio(EntityZombie,true)
				StopPedSpeaking(EntityZombie,true)
				SetEntityAsMissionEntity(EntityZombie,true,true)
			end

			for k,v in pairs(Entitys) do
				if DoesEntityExist(v) then
					local distance = #(coords - GetEntityCoords(v))
					if distance >= 200 or IsEntityInWater(v) then
						DeleteEntity(v)
						table.remove(Entitys,k)
					end
				else
					table.remove(Entitys,k)
				end
			end
		end

		Citizen.Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(Entitys) do
			if DoesEntityExist(v) then
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				local zombieCoords = GetEntityCoords(v)
				local distance = #(coords - zombieCoords)
				local targetDistance

				if Running() then
					targetDistance = 50
				elseif Shooting() then
					targetDistance = 120
				else
					targetDistance = 25
				end

				if distance <= targetDistance then
					if GetEntityHealth(ped) > 101 then
						TaskGoToEntity(v,ped,-1,0.0,2.0,1073741824,0)
						if distance <= 1.3 then
							if not IsPedRagdoll(v) and not IsPedGettingUp(v) then
								RequestAnimSet("melee@unarmed@streamed_core_fps")
								while not HasAnimSetLoaded("melee@unarmed@streamed_core_fps") do
									Citizen.Wait(10)
								end
				
								TaskPlayAnim(v,"melee@unarmed@streamed_core_fps","ground_attack_0_psycho",8.0,1.0,-1,48,0.001,false,false,false)
								ApplyDamageToPed(PlayerPedId(),5,false)
							end
						end
					else
						ClearPedTasks(v)
						TaskWanderStandard(v,10.0,10)
					end
				end
			end
		end
		
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RUNNING
-----------------------------------------------------------------------------------------------------------------------------------------
function Running()
	return isRunning
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOOTING
-----------------------------------------------------------------------------------------------------------------------------------------
function Shooting()
	return isShooting
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(Entitys) do
			if DoesEntityExist(v) then
				if IsPedDeadOrDying(v) then
					if math.random(1000) >= 700 then
						local lootCoords = GetEntityCoords(v)
						local zGround = GetGroundZFor_3dCoord(lootCoords["x"],lootCoords["y"],lootCoords["z"],true)
						TriggerServerEvent("inventory:zombieDrops",lootCoords["x"],lootCoords["y"],zGround)
					end

					table.remove(Entitys,k)
				end
			end
		end

		Citizen.Wait(1000)
	end
end)