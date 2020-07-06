/*
▒█▀▀▀ █▀▀▄ ▒█▀▀█ █▀▀█ ▒█▀▀█ █▀▀ ▒█░░▒█ ▄▀▀▄ 
▒█▀▀▀ █░░█ ▒█░░░ █░░█ ▒█▄▄▀ █▀▀ ░▒█▒█░ ▄▀▀▄ 
▒█▄▄▄ ▀░░▀ ▒█▄▄█ ▀▀▀▀ ▒█░▒█ ▀▀▀ ░░▀▄▀░ ▀▄▄▀

This is created by cabconmodding.com!

Please just edit it with permission!

*/


#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;
#include maps\_load_common;
#include maps\_zombiemode_utility;
#include maps\_zombiemode;

//Functions
#include maps\_zombiemode_perks;
#include maps\_zombiemode_audio;


#include maps\mod_cabcon\_load_menubase;
#include maps\mod_cabcon\_load_utilies;
#include maps\mod_cabcon\_load_settings;

Toggle_God()
{
    if(self.var["godmode"]==false)
    {
        S(getOptionName()+" ^2ON");
        self enableInvulnerability();
        self.var["godmode"]=true;
		while(self.var["godmode"])
		{
			self enableInvulnerability();
			wait 0.1;
		}
    }
    else
    {
        S(getOptionName()+" ^1OFF");
        self disableInvulnerability();
		self.maxhealth = 100;
		self.health = self.maxhealth;
        self.var["godmode"]=false;
    }
}

self Mainmenu("Tactical Grenades", "Grenade Menu");
    tactical = getArrayKeys(level.zombie_tactical_grenade_list);
    for(i = 0; i < tactical.size; i++)
    self MenuOption("Tactical Grenades", i, tactical[i], ::giveTheOffHand, tactical[i]);
    
    self MainMenu("Lethal Grenades", "Grenade Menu");
    lethal = getArrayKeys(level.zombie_lethal_grenade_list);
    for(i = 0; i < lethal.size; i++)
    self MenuOption("Lethal Grenades", i, lethal[i], ::giveTheOffHand, lethal[i]);


Toggle_Demi_God()
{
    if(self.var["godmode"]==false)
    {
        S(getOptionName()+" ^2ON");
        self.var["godmode"]=true;
		while(self.var["godmode"] == true)
		{
			self.maxhealth = 99999;
			self.health = self.maxhealth;
			wait 0.05;
		}	
    }
    else
    {
        S(getOptionName()+" ^1OFF");
		self disableInvulnerability();
		self.maxhealth = 100;
		self.health = self.maxhealth;
        self.var["godmode"]=false;
    }
}
	

give_perk_mod( perk )
{
	self.var["perk_allowed"] = false;
	vending_triggers = GetEntArray( "zombie_vending", "targetname" );
	if ( vending_triggers.size < 1 )
	{
			S( "Map does not contain any perks" );
			return;
	}
	for ( i = 0; i < vending_triggers.size; i++ )
	{
		if (vending_triggers[i].script_noteworthy == perk)
		{
			self.var["perk_allowed"] = true;
		}
	}
	if(self.var["perk_allowed"] == false)
	{
		S("^1Map does not contain this perk");
		return;
	}
	
	if(self HasPerk( perk ))
	{
		self notify( perk + "_stop" );
		S(getOptionName()+ "^1 Taken");
		return;
	}
	else
	{	
		S(getOptionName()+ "^2 Successful");
		if(getCurrent() == "main_perks_trigger")
		{
			vending_triggers[i] notify( "trigger", self );
		}
		else if(getCurrent() == "main_perks_set")
		{
			self give_perk( perk ); 
		}
		else if(getCurrent() == "main_perks_set_true")
		{
			self give_perk( perk, true );
		}
	}
}

modify_perks(perk,dvar_modify,default_var)
{
		if(self HasPerk( perk ))
		{	
			self quick_modificator(dvar_modify,0,default_var);
		}
		else
			S("^1You need the Perk "+getPerkwithName(perk)+"  to use this!");
}
getPerkwithName(perk)
{
	return perk;
}


multimenuperks(string,function,input1)
{
	 self addMenuPar_withDef("main_perks_set", string, function, input1);
	 self addMenuPar_withDef("main_perks_set_true", string, function, input1);
	 self addMenuPar_withDef("main_perks_trigger", string, function, input1);
}


//level.zombie_weapons[current_weapon].upgrade_name

Toggle_Spectator()
{ 
	if( self.sessionstate == "spectator" ) 
	{ 
		self.sessionstate = "playing"; 
		self allowSpectateTeam( "freelook", false ); 
		S( "Spectator Mode ^1OFF" ); 
	} 
	else 
	{ 
		if(isDefined(self.var["ufo_mode"]))
		{
			self.var["ufo_mode"] = undefined;
			self notify("ufo_mode_stop");
			S("Ufo-Mode ^1OFF");
		}
		self allowSpectateTeam( "freelook", true ); 
		self.sessionstate = "spectator"; 
		S( "Spectator Mode ^2ON" ); 
	} 
}

quick_modificator(input,i_1,i_2,i_3)
{
	
	if(isEmpty(i_3))
		i_3 = undefined;
	if(self.var[input]==0 || !isDefined(self.var[input]))
	{
		self setClientDvar( input, i_1 ); 
		self.var[input]=1;
		S(getOptionName()+" ^2ON^7 - var "+input+" set to "+i_1);
	}
	else if(self.var[input]==1)
	{
		self setClientDvar( input, i_2 ); 
		if(isDefined(i_3))
		{
			self.var[input]=2;
			S(getOptionName()+" ^2ON^7 - var "+input+" set to "+i_2);
		}
		else
		{
			self.var[input]=0;
			S(getOptionName()+" ^1OFF^7 - var "+input+" set to "+i_2);
		}
	}
	else if(self.var[input]==2)
	{
		self setClientDvar( input,i_3 ); 
		self.var[input]=0;
		S(getOptionName()+" ^1OFF^7 - var "+input+" set to "+i_3);
	}
	
}



func_spawn_zombie(ammount) //Spawn one AI //Updated with 0.9
{
		for(i=0;i<ammount;i++)
		{
			ai = spawn_zombie( level.enemy_spawns[RandomInt( level.enemy_spawns.size )] );
			L("AI spawned ID:"+i+" NUMBER:"+(i+1)+"");
		}
		if(ammount > 1)
			S(ammount+" AIs ^2Spawned");
		else
			S("1 AI ^2Spawned");
		
}

func_clonemodel(i)
{
	S(getOptionName()+" ^2Spawned");
	self.exp_clone = self ClonePlayer(1);
	if(i>=2)
		self.exp_clone startragdoll();
	if(i>=3)
	{	
		x = randomintrange(50, 100);
		y = randomintrange(50, 100);
		if(cointoss())
			x *= -1;
		else
			y *= -1;
		self.exp_clone launchragdoll((x, y, randomintrange(20, 30)));
	}
		
}
func_roundsystem(value,set)
{
	if(set == true)
		level.round_number = value;
	else
		level.round_number += value;
	S("Your Current Round will be Round ^2"+level.round_number);
	self func_calle_end(level.round_number);
}

func_calle_end(var_i)
{
	level.var_skipper = var_i;
	if(!isDefined(self.var["round_skipper_called"]) || !self.var["round_skipper_called"])
	{
		self.var["round_skipper_called"] = true;
		for(;;)
		{
			wait( 10.0 );
			L("var_1:"+level.var_skipper+" round_number:"+level.round_number);
			if( level.var_skipper < level.round_number)
			{
				self.var["round_skipper_called"] = undefined;
				return;
			}
			level thread maps\_zombiemode_powerups::nuke_powerup( self );
			S("Menu Sended a Nuke to End Round!");
		
		}
	}
	else
		L("^1Skipper Action already called.");
}

/**
VARS

level.chest_accessed  = wieoft die magic box benutzt wurde

BoxMove(i) //need testing
{	
	self notify("stop_boxmove");
	self endon("stop_boxmove");
	for(;;)
	{
		level.chest_accessed = i;wait 1;
	}
}


*/

weaponPackerPunchCurrentWeapon()
{
	if ( !self maps\_laststand::player_is_in_laststand() )		
	{
		weap = self getcurrentweapon();
		if(!self maps\_zombiemode_weapons::has_upgrade( weap ) || !self maps\_zombiemode_weapons::is_weapon_upgraded( weap ) )
		{
			weapon = get_upgrade( weap );
			if(isDefined(weapon))
			{
				self maps\_zombiemode_weapons::weapon_give(weapon);
				S("Weapon ("+weapon+") ^2Given");
			}
			else
				S("^1Weapon ("+weap+") can't packer punch.");
		}
		else
			S("^1Weapon ("+weap+") can't packer punch again.^7");
		
	}
	else
		S("^1You can't use packerpunch in the laststand.");
}

weaponDePackerPunchCurrentWeapon()
{
	if ( !self maps\_laststand::player_is_in_laststand() )		
	{
		weap = self getcurrentweapon();
		if(self maps\_zombiemode_weapons::is_weapon_upgraded( weap ) )
		{
			self maps\_zombiemode_weapons::weapon_give(getWeaponBaseName(weap));
		}
		else
			S("^1You can't unpack a non packed Weapon.");
	}
	else
		S("^1You can't use packerpunch in the laststand.");
}
func_takeWeapon()
{
	if(self getcurrentweapon() == "knife_zm")
	{
		S("^1You took all!");return;
	}
		self TakeWeapon( self getcurrentweapon() );
	S(self getcurrentweapon()+" ^2taken");
	
}


func_dropWeapon()
{
	//S(self getcurrentweapon()+" ^2dropped");
	//self setClientDvar("dropweapon","");
}


get_upgrade( weaponname )
{
	if( IsDefined(level.zombie_weapons[weaponname]) && IsDefined(level.zombie_weapons[weaponname].upgrade_name) )
	{
		return level.zombie_weapons[weaponname].upgrade_name;
	}
	else
	{
		return undefined;
	}
}

testNormalWeapon()
{
	weap = self getcurrentweapon();
	S("Weapon:" + getWeaponBaseName(weap));
}

getWeaponInfoString( name )
{
	return level.weaponInfo[name]["string"];
}
getWeaponBaseName( weaponname )
{
	if( !isdefined( weaponname ) || weaponname == "" )
	{
		return "This weaponname is unknown";
	}
	weaponname = ToLower( weaponname );
	weap_keys = GetArrayKeys( level.zombie_weapons );
	for ( i=0; i<level.zombie_weapons.size; i++ )
	{
		if ( IsDefined(level.zombie_weapons[ weap_keys[i] ].upgrade_name) && level.zombie_weapons[ weap_keys[i] ].upgrade_name == weaponname )
		{
			return ""+weap_keys[i];
		}
	}
	return ""+weaponname;
}
	//-------------------------Flashlight----------------------------------------------------------
	
_flashlightcolor(i)
{
	self setClientDvar( "r_flashLightColor", i ); 
	S("Flashlight Color setted to ^2"+getOptionName()+"");
}

/// fx_enable 1 / 0 



caller_ufomode()
{
	if(!isDefined(self.var["ufo_mode"]))
	{	
		if( self.sessionstate == "spectator" ) 
			{ 
				self.sessionstate = "playing"; 
				self allowSpectateTeam( "freelook", false ); 
				S( "Spectator Mode ^1OFF" ); 
			}
		self.var["ufo_mode"] = true;
		self thread func_ufomode();
		S("Ufo-Mode ^2ON");
		S("Press ^2[{+smoke}] ^7to use Ufo-Mode");
	}
	else
	{
		self.var["ufo_mode"] = undefined;
		self notify("ufo_mode_stop");
		S("Ufo-Mode ^1OFF");
	}
}

func_ufomode()
{
	self endon("ufo_mode_stop");
	self.clipmodel = spawn("script_model",self.origin);
	for(;;)
	{
		if(self SecondaryOffhandButtonPressed())
		{
			self playerLinkTo(self.clipmodel);
			self.Fly = 1;
		}
		else
		{
			self unlink();
			self.Fly = 0;
		}
		if(self.Fly == 1)
		{
			Fly = self.origin+vector_scale(anglesToForward(self getPlayerAngles()),20);
			self.clipmodel moveTo(Fly,.01);
		}
		wait .001;
	}
}



setScoreBoardColor(i)
{
	self notify("setScoreBoardColor_stop");
	self endon("setScoreBoardColor_stop");
	if(i == "flash")
	{
		while(true)
		{
		wait .1;
		self setClientDvar( "cg_scoresColor_Gamertag_0", ""+randomintrange( 0, 255 )/255+" "+randomintrange( 0, 255 )/255+" "+randomintrange( 0, 255 )/255+" 1 " );
		self setClientDvar( "cg_ScoresColor_Zombie", ""+randomintrange( 0, 255 )/255+" "+randomintrange( 0, 255 )/255+" "+randomintrange( 0, 255 )/255+" 1" );
		}
	}
	self setClientDvar( "cg_scorescolor_Gamertag_0", i);
	self setClientDvar( "cg_ScoresColor_Zombie", i);
	S("Scoreboard set to ^2"+getOptionName()+" ");
}

func_fxbullets( i )
{
	self notify("StopBullets");
	if(i == "_stop")
	{
		S("Modded Bullets ^1OFF");
		return;
	}
	self endon("StopBullets");
	S("Bullet Type set to ^2"+getOptionName());
	for(;;)
	{
		self waittill( "weapon_fired" );
		forward = self geteye();
		vec = anglesToForward( self getPlayerAngles() );
		end = ( vec[0] * 100000000, vec[1] * 100000000, vec[2] * 100000000 );
		Loc = BulletTrace( forward, end, 0, self )[ "position" ];
		PlayFx( level._effect[i], Loc );
	}
}
func_gunbullets(i)
{
	self notify("StopBullets");
	if(i == "_stop")
	{
		S("Modded Bullets ^1OFF");
		return;
	}
	self endon("StopBullets");
	S("Bullet Type set to ^2"+getOptionName());
	for(;;)
	{
		self waittill("weapon_fired");
		start = self getTagOrigin("tag_eye");
		vec = self Bullet(anglestoforward(self getPlayerAngles()),1000000);
		Loc = BulletTrace( start, vec, 0, self )[ "position" ];
		MagicBullet( i, start, Loc, self );
	}
}
Bullet(A,B)
{
	return (A[0]*B,A[1]*B,A[2]*B);
}

SpawnModel(i)
{
	l("Function delted!");
}

///*******************************************************************************************************************************///
/// Power Ups                                                 																	  ///
///*******************************************************************************************************************************///

func_call_powerups_force(i) 
{
					switch (i)
					{
					case "nuke":
						level thread maps\_zombiemode_powerups::nuke_powerup( self );
						self thread maps\_zombiemode_powerups::powerup_vo("nuke");
						zombies = getaiarray("axis");
						self.zombie_nuked = get_array_of_closest( self.origin, zombies );
						self notify("nuke_triggered");
						break;
					case "full_ammo":
						level thread maps\_zombiemode_powerups::full_ammo_powerup( self );
						self thread maps\_zombiemode_powerups::powerup_vo("full_ammo");
						break;
					case "double_points":
						level thread maps\_zombiemode_powerups::double_points_powerup( self );
						self thread maps\_zombiemode_powerups::powerup_vo("double_points");
						break;
					case "insta_kill":
						level thread maps\_zombiemode_powerups::insta_kill_powerup( self );
						self thread maps\_zombiemode_powerups::powerup_vo("insta_kill");
						break;
					case "carpenter":
						level thread maps\_zombiemode_powerups::start_carpenter( self.origin );
						self thread maps\_zombiemode_powerups::powerup_vo("carpenter");
						break;
					case "fire_sale":
						level thread maps\_zombiemode_powerups::start_fire_sale( self );
						self thread maps\_zombiemode_powerups::powerup_vo("firesale");
						break;
					case "bonfire_sale":
						level thread maps\_zombiemode_powerups::start_bonfire_sale( self );
						self thread maps\_zombiemode_powerups::powerup_vo("firesale");
						break;
					case "minigun":
						level thread maps\_zombiemode_powerups::minigun_weapon_powerup( self );
						self thread maps\_zombiemode_powerups::powerup_vo( "minigun" );
						break;
					case "free_perk":
						level thread  maps\_zombiemode_powerups::free_perk_powerup( self );
						break;
					case "all_revive":
						level thread maps\_zombiemode_powerups::start_revive_all( self );
						self thread maps\_zombiemode_powerups::powerup_vo("revive");
						break;
					case "tesla":
						level thread maps\_zombiemode_powerups::tesla_weapon_powerup( self );
						self thread maps\_zombiemode_powerups::powerup_vo( "tesla" );
						break;
					case "bonus_points_player":
						level thread maps\_zombiemode_powerups::bonus_points_player_powerup( self, self );
						self thread maps\_zombiemode_powerups::powerup_vo( "bonus_points_solo" ); 
						break;
					case "bonus_points_team":
						level thread maps\_zombiemode_powerups::bonus_points_team_powerup( self );
						self thread maps\_zombiemode_powerups::powerup_vo( "bonus_points_team" ); 
						break;
					default:
							S("Unrecognized powerup.");
						break;
					}
					S("^1"+getOptionName()+" forced!");
}
func_call_powerups( powerup_name )
{
	
	self notify("func_call_powerups_stop");
	self endon("func_call_powerups_stop");
	if( !isDefined( level.zombie_include_powerups ) || !level.zombie_include_powerups.size )
	{
		S("Level don't include any powerups.");
		return;
	}
	if(!IsDefined( level.zombie_include_powerups[powerup_name] ) )
	{
		S("^1This powerup can't drop!");
		S("You can force the system to drop it by pressing ^2[{+smoke}]^7");
		for(i = 1;i < 100;i++)
		{
			if(self SecondaryOffhandButtonPressed())
			{
				self func_call_powerups_force(powerup_name);
				return;
			}
			wait .025;
		}
		L("To late..");
		return;
	}
	level thread maps\_zombiemode_powerups::specific_powerup_drop(powerup_name ,self.origin );
	S(getOptionName()+" ^2Successful");
	/*
	TODO CabCon: in maps/_zombiemode_powerups.gsc edited to get the input of the menu. as a grab. 
	*/
	
	
}
///*******************************************************************************************************************************///
/// Entitys                                                 																	  ///
///*******************************************************************************************************************************///
	
func_create_entity_menu()
{
	var_names = getentarray("script_model", "classname");
	for( i = 0; i < var_names.size; i++ )
	{
		if(!isDefined(level._objectModels))
			level._objectModels = [];
		if(!isDefined(level._objectModels[var_names[i].model]) && !IsSubStr(var_names[i].model, "collision")  && !IsSubStr(var_names[i].model, "tag_"))
		{
			level._objectModels[var_names[i].model] = var_names[i].model;
			level._objectModels[var_names[i].model].name = getEntityModelName(var_names[i].model);
		}
	}
	self CreateArrayItemMenu("main_entity_models","main_entity","Entity Menu","",::func_entitySelection,level._objectModels,::getEntityModelName);
}

addCostumModel(i)
{
	if(!isDefined(level._objectModels))
			level._objectModels = [];
	precachemodel(i);
	if(!isDefined(level._objectModels[i]))
	{
		level._objectModels[i] = i;
		level._objectModels[i].name = getEntityModelName(i);
	}
}
getEntityModelName(i)
{
	switch(i)
	{
		case "zombie_vending_three_gun": i = "Additionalprimaryweapon Perk Vendor";  break;
		case "zombie_theater_chandelier1_off": i = "Chandelier Barre Part";  break;
		case "zombie_theater_curtain": i = "Kino Curtain";  break;
		case "zombie_vending_packapunch": i = "Packer Punch Perk Vendor";  break;
		case "zombie_vending_jugg": i = "Juggernaut Perk Vendor";  break;
		case "zombie_vending_sleight": i = "Speed Cola Perk Vendor";  break;
		case "zombie_vending_doubletap": i = "Doubletap Perk Vendor";  break;
		case "zombie_vending_revive_on": i = "Quickrevive Perk Vendor";  break;
		case "zombie_coast_bearpile": i = "Magicbox Scrap";  break;
		case "zombie_treasure_box_lid": i = "Magicbox Cover";  break;
		case "zombie_power_lever_handle": i = "Power Zapper";  break;
		case "zombie_zapper_cagelight_red": i = "Red Light";  break;
		case "zombie_zapper_handle": i = "Zapper Baton";  break;
		case "zombie_theater_reelcase_obj": i = "Film Strip Role";  break;
		case "zombie_zapper_cagelight": i = "Off Light";  break;
		case "p_int_blue_door": i = "Blue Save Door";  break;
		case "p_pent_double_doors_win_left": i = "Hospital Door Left";  break;
		case "p_pent_double_doors_win_right": i = "Hospital Door Right";  break;
		case "anim_int_interrogation_chair_ui": i = "Interrogation Chair";  break;
		case "t5_weapon_mpl_world": i = "MPL Weapon Model";  break;
		case "t5_weapon_ak74u_world": i = "Ak74u Weapon Model";  break;
		case "t5_weapon_pm63_world": i = " PM63 Weapon Model";  break;
		case "t5_weapon_beretta682_world": i = "Olympia Weapon Model";  break;
		case "grenade_bag": i = "Grenade Bag";  break;
		case "world_knife_bowie": i = "Bowie Knife";  break;
		case "t5_weapon_m16a1_world": i = "M16A1 Weapon Model";  break;
		case "weapon_claymore": i = "Claymore Model";  break;
		case "weapon_ger_mp40_smg": i = "MP40 Weapon Model";  break;
		case "t5_weapon_m14_world": i = "M14 Weapon Model";  break;
		case "t5_weapon_mp5_world": i = "MP5 Weapon Model";  break;
		case "zombie_revive": i = "Sanitary Cross Drop Model";  break;
		case "zombie_z_money_icon": i = "Points Drop Model";  break;
		case "zombie_teddybear": i = "Zombie Teddybear";  break;
		case "defaultactor": i = "Default Actor";  break;
		case "test_sphere_silver": i = "Silver Sphere";  break;
		case "zombie_theater_chandelier1arm_off": i = "Chandelier Arm Part";  break;
		case "p_zom_clock_sechand": i = "Red Stripe";  break;
		case "zombie_treasure_box": i = "Magicbox Box";  break;
		case "t5_weapon_ithaca_world": i = "Stakeout Weapon Model";  break;
		case "zombie_sumpf_power_switch": i = "Red Electric Box";  break;
		case "p_zom_emergency_phone": i = "Red Telephone";  break;
		case "p_pent_elevator_parts": i = "Elevator Electric Parts";  break;
		case "p_pent_door_elevator_wood_right": i = "Elevator Wood Side Part";  break;
		case "p_pent_door_elevator_wood_left": i = "Elevator Wood Side Part";  break;
		case "p_pent_door_elevator_metal_right": i = "Elevator Metal Side Part";  break;
		case "p_pent_door_elevator_metal": i = "Elevator Metal Side Part";  break;
		case "p_pent_elevator_control_panel": i = "Elevator Control Panel";  break;
		case "p_pent_gov_seal_pres": i = "Governor Plate";  break;
		case "zombie_sign_please_wait": i = "Please Wait Sign";  break;
		case "viet_pig": i = "Pig";  break;
		case "zombie_trap_switch_handle": i = "Trap Switcher";  break;
		case "zombie_trap_switch_light": i = "Trap Switcher Light";  break;
		case "p_zom_pent_defcon_sign_01": i = "Defcon 1 Sign";  break;
		case "p_glo_electrical_transformer": i = "Electrical Transformer";  break;
		case "zombie_vending_nuke": i = "Flopper Phd Perk Vendor";  break;
		case "zombie_vending_marathon": i = "Stamin Up Perk Vendor";  break;
		case "zombie_vending_ads": i = "Deadshot Perk Vendor";  break;
		case "semtex_bag": i = "Semtex Bag";  break;
		case "zombie_skull": i = "Zombie Skull";  break;
		default:  i = "&"+i; break;
	}
	return i;
}


//Programmer v2 Sytem

func_spawnEntityModelView()
{
	self endon("disconnect");
	self.menu["isLocked"] = true;
	self controlMenu("close"); 
	wait 0.5;
	self S("Press ^3[{+attack}]^7/^3[{+speed_throw}]^7 to Change Model");
	self S("Press ^3F ^7to select Model");
	self S("Press ^3[{+melee}]^7 to close.");
	entity_models = GetArrayKeys(level._objectModels);
	if(!isDefined(self.curser))
		self.curser = 0;
	self func_entitySelection(entity_models[self.curser]);
	for(;;)
	{
		if( self attackButtonPressed() || self adsButtonPressed())
		{
			self.curser -= self adsButtonPressed();
			self.curser += self attackButtonPressed();
			if(self.curser < 0) 
				self.curser = entity_models.size-1;
			if(self.curser > entity_models.size-1)
				self.curser = 0;
			L("model key: "+self.curser);
			self func_entitySelection(entity_models[self.curser]);
			wait 0.5;
		}
		if( self useButtonPressed())
		{
			if(!isDefined(self.selectedModel))
				S("^1You need to select a model!");
			else
				S("Selceted Model is ^2"+self.selectedModel);
			wait 0.5;
			self.menu["isLocked"] = false;
			self controlMenu("open_withoutanimation","main_entity");
			break;
		}
		if(self meleeButtonPressed())
		{
			func_deleteentity();
			wait 0.5;
			self.menu["isLocked"] = false;
			self controlMenu("open_withoutanimation","main_entity");
			break;
		}
		wait 0.05;
	}
}


func_entitySelection(model)
{
	vector = self getEye()+vector_scale(anglesToForward(self getPlayerAngles()), 50); // changes this maybe later to a other value
	if(!isDefined(self.selectedModel))
	{
		self.selectedModel = spawn("script_model", vector);
		entity_cacheFunction(self.selectedModel);
		self thread func_moveCurrentModel();
	}
	self.selectedModel setModel(model);
	if(!isDefined(self.selectedModel.spin))
		self.selectedModel.spin = [];
	self func_resetModelAngles();
	S("Your selected Model is ^2"+getEntityModelName(model));
}

func_moveCurrentModel()//credits to programmer v2 creator!
{
	self notify("func_moveCurrentModel_stop");
	self endon("func_moveCurrentModel_stop");
	self endon("disconnect");
	self endon("death");
	if(!isDefined(self.modelDistance))
		self.modelDistance = 250;
	while(isDefined(self.selectedModel))
	{
		self.selectedModel moveTo(bulletTrace(self getEye(), self getEye()+vector_scale(anglesToforward(self getPlayerAngles()), self.modelDistance), false, self.selectedModel)["position"], .1);
		wait .05;
	}
}

func_placemodel()
{
	if(isdefined(self.selectedModel))
	{
		self notify("func_moveCurrentModel_stop");
		self.selectedModel = undefined;	
	}
	else
		S("^1You need to select a model first!");	
}

func_dropmodel()
{
	self.selectedModel thread alwaysphysical();
	if(isdefined(self.selectedModel))
	{
		self notify("func_moveCurrentModel_stop");
		self.selectedModel = undefined;	
	}
	else
		S("^1You need to select a model first!");	
}
func_deleteentity()
{
	if(!isDefined(self.selectedModel))
	{
		S("^1You need to select a model first!");	
		return;
	}
	self notify("func_moveCurrentModel_stop");
	level._cachedEntitys[level._cachedEntitys.size-1] Delete();
	level._cachedEntitys[level._cachedEntitys.size-1] = undefined;
	self.selectedModel = undefined;
	S("Model deleted");	
}

func_entity_distance(i)
{
	self.modelDistance = self.modelDistance + i;
	S("Model Distance set to ^2"+self.modelDistance);
}


rotateCurrentModel(num, times) //Credits to programmer v2 creator
{
	self.selectedModel.spin[num]+= (10*(times));
	self.selectedModel rotateTo((self.selectedModel.spin[0], self.selectedModel.spin[1], self.selectedModel.spin[2]), 1, 0, 1);
}

func_resetModelAngles()
{
	self.selectedModel.spin[0] = 0;
	self.selectedModel.spin[1] = 0;
	self.selectedModel.spin[2] = 0;
	self.selectedModel.angles = (self.selectedModel.spin[0],self.selectedModel.spin[1],self.selectedModel.spin[2]);
}

entity_cacheFunction(entity)
{
	if(!isDefined(level._cachedEntitys))
		level._cachedEntitys = [];
	level._cachedEntitys[level._cachedEntitys.size] = entity;
}

entity_deleteCache()
{
	if(!isDefined(level._cachedEntitys))
	{
		S("^1No Entitys in spawned!");
		return;
	}
	else
	{
		S("All Entitys ("+level._cachedEntitys.size+") deleted.");
		for(i = 0; i < level._cachedEntitys.size; i++)
		{
			level._cachedEntitys[i] notify("alwaysphysical_stop");
			level._cachedEntitys[i] delete();
		}
		level._cachedEntitys = undefined;
		
	}
}

test_size()
{
	if(isDefined(self.selectedModel))
		self.selectedModel.modelscale = self.selectedModel.modelscale + 1;
	else
		S("need def");
}

///*******************************************************************************************************************************///
/// Functions                                        																	  ///
///*******************************************************************************************************************************///
	
rotateAngles()
{
	self setPlayerAngles((self getPlayerAngles()[0],self getPlayerAngles()[1],self getPlayerAngles()[2]+90));
	S("You rotated to ^2"+self getPlayerAngles()[2]);
}
func_earthquake()
{ 
   S("Earthquake ^2Started");
   earthquake(0.6,5,self.origin,100000000);
}

func_endgame()
{
	S("Game will end in a few Secounds...");
	wait 3;
	level notify("pre_end_game");
	wait_network_frame();		
	level notify( "end_game" );
	S("Game ended ^2Successful");
}
func_restartgame()
{
	S("Game will restart in a few Secounds...");
	wait 3;
	map_restart(false);
	S("Game restarted ^2Successful");
}

func_moddedtracer()
{
	if(!self.var["modded_tracer"])
	{
		self setClientDvar( "cg_tracerSpeed", "100" ); // 7500
		self setClientDvar( "cg_tracerwidth", "9" ); // 3
		self setClientDvar( "cg_tracerlength", "999" ); //100
		self setClientDvar( "cg_firstPersonTracerChance", "1" ); //0
		self.var["modded_tracer"] = true;
		S("Modded Tracer ^2ON");
	}
	else
	{
		self setClientDvar( "cg_tracerSpeed", "7500" );
		self setClientDvar( "cg_tracerwidth", "3" );
		self setClientDvar( "cg_tracerlength", "100" );
		self setClientDvar( "cg_firstPersonTracerChance", "0" );
		self.var["modded_tracer"] = false; 
		S("Modded Tracer ^1OFF");
	}
}

func_autotbag()
{
	self endon("modded_tracer_stop");
	if(!self.var["modded_tracer"])
	{
		self.var["modded_tracer"] = true;
		S("Auto T-Bag ^2ON");
		for(;;)
		{
			self SetStance("crouch");
			wait 0.3;
			self SetStance("stand");
			wait 0.3;
		}
	}
	else
	{
		self.var["modded_tracer"] = false;
		self notify ("modded_tracer_stop");
		S("Auto T-Bag ^1OFF");
	}
}
func_invisible()
{
	if(!self.var["invisible"])
	{
		self hide();
		self.var["invisible"] = true;
		S("You are ^2Invisible");
	}
	else
	{
		self show();
		self.var["invisible"] = false; 
		S("You are ^1Visible");
	}
}
setDvarFunction_mod_cg_gun(pos_value,value)
{
	self setClientDvar("cg_gun_"+pos_value,value);
	S("Gun Position ^2"+pos_value+"^7 setted to ^2"+value);
}

setDvarFunction_(dvar,value)
{
	self setClientDvar(dvar,value);
	S("Var ^2"+dvar+"^7 setted to ^2"+value);
}

def_call_main_weapons_mods_viewmodel_pos()
{
	setDvarFunction_("cg_fov",65);
	setDvarFunction_("cg_gun_x",0);
	setDvarFunction_("cg_gun_y",0);
	setDvarFunction_("cg_gun_z",0);
}

func_doJetPack()//by pix
{
	if(!self.var["jetpack"])
	{
		self thread StartJetPack();
		self S("JetPack ^2ON^7");
		self S("Press [{+use_button}] foruse jetpack");
		self.var["jetpack"]=true;
	}
	else
	{
		self.var["jetpack"]=undefined;
		self notify("jetpack_off");
		self S("JetPack ^1OFF^7");
	}
}
StartJetPack()
{
	self endon("jetpack_off");
	self.jetboots= 100;
	for(i=0;;i++)
	{
		if(self usebuttonpressed() && self.jetboots>0)
		{
			earthquake(.15,.2,self gettagorigin("j_spine4"),50);
			self.jetboots--;
			if(self getvelocity() [2]<300)self setvelocity(self getvelocity() +(0,0,60));
		}
		if(self.jetboots<100 &&!self usebuttonpressed())self.jetboots++;
		wait .05;
	}
}

func_togglePostionSystem_save()
{
	self.var["pos_self_saved"]=self.origin;
	S("Position ^2Saved");L(self.var["pos_self_saved"]);
}
func_togglePostionSystem_load()
{
	if(isDefined(self.var["pos_self_saved"]))
	{
		self setOrigin(self.var["pos_self_saved"]);
		S("Position ^2Loaded");L(self.var["pos_self_saved"]);
	}
	else
		S("^1You need to save a position first!");
}
func_togglePostionSystem_load_zombz()
{
	if(isDefined(self.var["pos_self_saved"]))
	{
		if(!isDefined(self.var["pos_zombz_loop"]) || self.var["pos_zombz_loop"] == false )
		{
			S("Zombies Teleported to the Saved Location.");
			self ThreadAtAllZombz(::teleportZomZtoPosition,self.var["pos_self_saved"]);
		}
		else
			S("^1Turn Location Spawn Trapper ^1OFF");
			
	}
	else
		S("^1You need to save a position first!");
}
func_togglePostionSystem_load_zombz_loop()
{
	if(isDefined(self.var["pos_self_saved"]))
	{
		if(!isDefined(self.var["pos_zombz_loop"]) || self.var["pos_zombz_loop"] == false )
		{
			self.var["pos_zombz_loop"] = true;
			self.var["pos_zombz_spawn"] = false;
			S("Zombies will teleport in a loop to the Saved Location.");
			while(self.var["pos_zombz_loop"] == true)
			{
				self ThreadAtAllZombz(::teleportZomZtoPosition,self.var["pos_self_saved"]);
				wait .1;
			}
		}
		else		
		{
			self.var["pos_zombz_loop"] = false;
			S("Location Spawn Trapper ^1OFF");
		}
			
	}
	else
		S("^1You need to save a position first!");
}

func_togglePostionSystem_load_zombz_spawn()
{
	if(isDefined(self.var["pos_self_saved"]))
	{
		if(!isDefined(self.var["pos_zombz_spawn"]) || self.var["pos_zombz_spawn"] == false )
		{
			self.var["pos_zombz_spawn"] = true;
			self.var["pos_zombz_loop"] = false;
			S("Zombies spawn set to the Saved Location.");
			while(self.var["pos_zombz_spawn"] == true)
			{
				self ThreadAtAllZombz(::teleportZomZtoPosition_just_onetime,self.var["pos_self_saved"]);
				wait .1;
			}
		}
		else		
		{
			self.var["pos_zombz_spawn"] = false;
			S("Location Spawn Trapper ^1OFF");
		}
			
	}
	else
		S("^1You need to save a position first!");
}

teleportZomZtoPosition_just_onetime(i)
{
	if(!isDefined(self.teleported_already))
		self.teleported_already = false;
	if(!self.teleported_already)
	{
		self.teleported_already = true;
		wait 1.5;
		self forceTeleport( i );
		self maps\_zombiemode_spawner::reset_attack_spot();
	}
}


teleportZomZtoPosition(i)
{
	self forceTeleport( i );
	self maps\_zombiemode_spawner::reset_attack_spot();
}


func_togglePostionSystem_modify_pos(i)
{
	if(isDefined(self.var["pos_self_saved"]))
	{
		self.var["pos_self_saved"] += i;
		S("X:^2"+self.var["pos_self_saved"][0]+"^7 Y:^2"+self.var["pos_self_saved"][1]+"^7 Z:^2"+self.var["pos_self_saved"][2]+"^7");
	}
	else
		S("^1You need to save a position first!");
}	

func_ammo_refill()
{
	if(self getCurrentWeapon()!="none")
	{
		if(isSubStr(self getCurrentWeapon(),"_akimbo_"))
		{
			self setWeaponAmmoClip(self getCurrentWeapon(),9999,"left");
			self setWeaponAmmoClip(self getCurrentWeapon(),9999,"right");
		}
		else
		{
			self setWeaponAmmoClip(self getCurrentWeapon(),9999);
		}
		self GiveMaxAmmo(self getCurrentWeapon());
	}
	if(self GetCurrentOffhand()!="none")
	{
		self setWeaponAmmoClip(self GetCurrentOffhand(),9999);
		self GiveMaxAmmo(self GetCurrentOffhand());
	}
	S("Ammo ^2refilled");
}


func_sound_dialog(cat,type)
{
	S("^1Dialog Menu is in process and will come with the next update.^7 Your Version: ^3"+self.menu["version"]);
	self maps\_zombiemode_audio::create_and_play_dialog( cat, type );
	S("You played Category: ^2"+cat+"^7 Type: ^2"+type);
}
func_sound(i)
{
	self stopSounds();
	self PlaySound(i);
	S("Name ^2"+getOptionName());
}
func_sound_no_print(i)
{
	if(getMenuSetting("sound_in_menu"))
		self PlaySound(i);
}
func_alwaysphysical(model)
{
	self.modelEnt = spawn("script_model",self.origin+(0,0,100));
	self.modelEnt setmodel(model);
	self.modelEnt thread alwaysphysical();
	entity_cacheFunction(self.modelEnt);
}
	

alwaysphysical()
{
	self endon("death");
	self endon("alwaysphysical_stop");
	for(;;)
	{
		self physicslaunch();
		wait 0.1;
	}
}
func_detachAll()
{
	self detachAll();
}
func_setModel(i)
{
	self setModel(i);
}

func_vision(i)
{
	self VisionSetNaked( i, .5 );
	S("Vision set to ^2"+getOptionName());
	L("INPUT:"+i);
}

/*

Enviro Mods

*/

//Fog Editor

func_changeFog(fogOne)
{
	S(getOptionName());
	fogColor1 = strTok(fogOne, " ");
	self SetExpFog(256, 512, int(fogColor1[0]), int(fogColor1[1]), int(fogColor1[2]), int(fogColor1[3]));
	self SetVolFog( 165, 835, 200, 75, int(fogColor1[0]), int(fogColor1[1]), int(fogColor1[2]), int(fogColor1[3]));
	self notify("FC");
}

func_DiscoFog()
{
	S(getOptionName());
	self notify("FC");
	self endon("FC");
	for(;;)
	{
		F1 = RandomFloat( 1 );
		F2 = RandomFloat( 1 );
		F3 = RandomFloat( 1 );
		self setExpFog( 256, 512, F1, F2, F3, 0 );
		wait .1;
	}
}

//Sun Editor

func_changeSun(Light, Color)
{
	S(getOptionName());
	self notify("sunchange");
	self setClientDvar( "r_lightTweakSunLight", Light ); //D: kino: 13
	self setClientDvar( "r_lightTweakSunColor", Color ); //D: kino: lock function index
}

func_DiscoSun()
{
	S(getOptionName());
	self notify("sunchange");
	self endon("sunchange");
	for(;;)
	{
		self setClientDvar( "r_lightTweakSunLight", self.function_defaultSize["r_lightTweakSunLight"] );
		self setClientDvar( "r_lightTweakSunColor", "1 0 0 0" );
		wait .15;
		self setClientDvar( "r_lightTweakSunLight", self.function_defaultSize["r_lightTweakSunLight"] );
		self setClientDvar( "r_lightTweakSunColor", "0 0 1 1" );
		wait .15;
		self setClientDvar( "r_lightTweakSunLight", self.function_defaultSize["r_lightTweakSunLight"] );
		self setClientDvar( "r_lightTweakSunColor", "0 1 0 0" );
		wait .15;
		self setClientDvar( "r_lightTweakSunLight", self.function_defaultSize["r_lightTweakSunLight"] );
		self setClientDvar( "r_lightTweakSunColor", "1 0 1 0" );
		wait .15;
		self setClientDvar( "r_lightTweakSunLight", self.function_defaultSize["r_lightTweakSunLight"] );
		self setClientDvar( "r_lightTweakSunColor", "1 1 0 0");
		wait .15;
		self setClientDvar( "r_lightTweakSunLight", self.function_defaultSize["r_lightTweakSunLight"] );
		self setClientDvar( "r_lightTweakSunColor", "0 0 0 0" );
		wait .15;
	}
}


func_noTarget()
{
	if(!self.ignoreme)
	{
		S("No Target ^2ON");
		self.ignoreme = true;
	}
	else
	{
		S("No Target ^1OFF");
		self.ignoreme = false;
	}
}

func_healthShield()
{
	if(!self.var["healthShield"])
	{
		self.var["healthShield"] = true;
		self enableHealthShield(true);
		S("Health Shield ^2ON");
	}
	else
	{
		self.var["healthShield"] = undefined;
		self enableHealthShield(false);
		S("Health Shield ^1OFF");
	}
}

print_get_current_corpse_count() //works perfectly !
{
self S("Current Corpse Count ^2"+get_current_corpse_count());
}
print_get_current_zombz_count() //works perfectly !
{
self S("Current Zombie Count ^2"+get_current_zombie_count());
}
print_get_pos() //works perfectly !
{
	self iprintln("Your Position ^2"+self.origin+"^7.");
}
get_current_zombie_count()
{
	enemies = getAIArray("axis");
	return enemies.size;
}
get_current_corpse_count() //works perfectly !
{
	corpse_array = getcorpsearray();
	if ( isDefined( corpse_array ) )
	{
		return corpse_array.size;
	}
	return 0;
}


//**********************************************

fx_system(effect,range)
{
	self notify("stop_me_my_friend");
	self endon("stop_me_my_friend");
	self.var["fx_system"] = true;
	if(!isDefined(level._effect[ effect ]))
	{
		S("^1This Function needs this Effect :"+effect+". Which is not implemented on this Map.");
		return 0;
	}
	if(!isDefined(range))
		range = 500;
	for(;;)
	{
		pos_d = getRandomPos(400);
		PlayFX( level._effect[effect], pos_d);
		self RadiusDamage( pos_d, 100, 200, 100);
		wait RandomFloatRange( 0, .2 );
		if(randomintrange( 0, 10 )==5)
			wait RandomFloatRange( 2, 7 );
	}
}
fx_system_stop()
{
	if(self.var["fx_system"] == false)
	{
		self notify("stop_me_my_friend");
	}
	else	
		S("^1Is alreasy OFF. Select a FX to start the FX System.");
}

Toogler_FX_System(effect,range)
{
	self notify("stop_me_my_friend");
	self endon("stop_me_my_friend");
	self.var["fx_system"] = !self.var["fx_system"];
	if(self.var["fx_system"] == true)
	{
		S(getOptionName()+" ^2ON");
		self thread fx_system(effect,range);
	}
	else
	{
		S(getOptionName()+" ^1OFF");
		self thread fx_system_stop(); 
	}
}
getRandomPos(value,value_z)
{
if(!isDefined(value_z))
	value_z = 0;
return self.origin + (randomintrange(0-value,value),randomintrange(0-value,value),value_z);
}

func_flashingPlayer()
{
	if(!isDefined(self.var["flashingPlayer"]))
	{
		self.var["flashingPlayer"] = true;
		self thread doFlashyPlayer();
		S("Flashing Player ^2ON^7");
	}
	else
	{
		self.var["flashingPlayer"] = undefined;
		self notify("flashingPlayer_over");
		S("Flashing Player ^1OFF^7");
		self show();
	}
}

doFlashyPlayer()
{
	self endon("death");
	self endon("disconnect");
	self endon("flashingPlayer_over");
	for(;;)
	{
		self show();
		wait .1;
		self hide();
		wait .1;
	}
}

func_IceSkater()
{
	if(!isdefined(self.var["iceskater"]))
	{
		self.var["iceskater"] = true;
		S("Ice Skater ^2SPAWNED");
		self endon("death");
		self endon("stophere");
		self.skater = spawn("script_model",self.origin);
		entity_cacheFunction(self.skater);
		self.skater setmodel("defaultactor");
		while(1)
		{
			self.skater RotateYaw(9000,9);self.skater MoveY(-180,1);wait 1;self.skater MoveY(180,1);wait 1;self.skater MoveX(-180,1);wait 1;self.skater MoveX(180,1);wait 1;self.skater MoveZ(90,.5);wait.5;self.skater MoveZ(-90,.5);wait.5;self.skater MoveY(180,1);wait 1;self.skater MoveY(-180,1);wait 1;self.skater MoveX(180,1);wait 1;self.skater MoveX(-180,1);wait 1;
		}
	}
	else
	{
		self notify("stophere");
		self.var["iceskater"] = undefined;
		self.skater hide();
		self.skater destroy();
		S("Ice Skater ^1DESTROYED");
	}
}
func_dancingZombz()
{
	if(!isDefined(self.var["func_dancingZombz"]))
	{
		self.var["func_dancingZombz"] = true;
		self func_zombzChangeStance("crouch");
		S("Dancing Zombies ^2ON");
	}
	else
	{
		self.var["func_dancingZombz"] = undefined;
		self func_zombzChangeStance("stand");
		S("Dancing Zombies ^2ON");
	}
}

func_zombzChangeStance(type)
{
	for(i = 0; i < getZombz().size; i++)
		getZombz()[i] allowedStances(type);
}

func_spawnAZombieBoss()
{
	L("boss_main -> called");
	if(self.var["ZOMBIE_BOSS"])
		return;
	if(getZombz().size < 0)
	{
		S("No Zombie found!");
		return; 
	}
	self.var["ZOMBIE_BOSS"] = true;
	boss = getZombz();
	// boss 0 is the current boss
	
	boss[0] attach("zombie_skull", "J_Eyeball_LE", true);
	boss[0] attach("zombie_teddybear", "J_Ankle_LE", true);
	boss[0] attach("zombie_teddybear", "J_Ankle_RI", true);
	
	self thread boss_healthmonetoring(boss[0]);
	self thread boss_think(boss[0]);
	self thread boss_think_death(boss[0]);
	
	self PlaySound("zmb_engineer_spawn");
	L("boss_main -> called_end");
	wait 2;
	self PlaySound("fly_step_engineer");
}

boss_healthmonetoring(i)
{
	i.health = 100000;
	self.var["ZOMBIE_BOSS_HEALTH"] = 1;
	while(self.var["ZOMBIE_BOSS"])
	{
		if(self.var["ZOMBIE_BOSS_HEALTH"] != i.health)
		{
			S("Boss health ^2"+i.health);
			self.var["ZOMBIE_BOSS_HEALTH"] = i.health;
			wait .1;
		}
		wait 0.025;
	}
}

boss_think(i)
{
	while(self.var["ZOMBIE_BOSS"])
	{
		if(Distance( self.origin, i.origin ) <= 50 || randomIntRange(1,20)== 10)
		{
			S("^1Boss is angry! Run....");
			i setMovmentSpeed("idle");
			self PlaySound("zmb_engineer_vocals_death");
			self PlaySound("fly_step_engineer");
			if(isDefined(level._effect["poltergeist"]))
				PlayFX(level._effect["poltergeist"], i.origin);
			if(isDefined(level._effect["poltergeist"]))
				PlayFX(level._effect["poltergeist"], i.origin);
			wait .5;
			earthquake(0.6,5,i.origin,100);
			i setMovmentSpeed("sprint");
			wait 2;
			earthquake(0.6,5,i.origin,100);
			wait 3;
			self PlaySound("fly_step_engineer");
			earthquake(0.6,5,i.origin,100);
			wait 3;
			self PlaySound("fly_step_engineer");
			earthquake(0.6,5,i.origin,100);
			wait 2;
			self PlaySound("fly_step_engineer");
			earthquake(0.6,5,i.origin,1000);
			if(isDefined(level._effect["poltergeist"]))
				PlayFX(level._effect["poltergeist"], i.origin);
		}	
		else if(Distance( self.origin, i.origin ) <= 200 || randomIntRange(1,20)== 10)
		{
			L("touch boss");
			self PlaySound("zmb_elec_vocals");
			i setMovmentSpeed("run");
			wait 3;
		}
		else 
			i setMovmentSpeed("walk");
		wait .5;
	}
}

boss_think_death(i)
{
	for(;;)
	{
		if(i.health < 0)
		{
			self.var["ZOMBIE_BOSS"] = false;
			self PlaySound("evt_nuked");
			self PlaySound("evt_challenge_complete");
			L("Boss is death");
			break;
		}
		wait 0.1;
	}
}


setMovmentSpeed(i)
{
	self maps\_zombiemode_spawner::set_zombie_run_cycle(i);
	L("Movment Cycle ^2changed");
}


test_call()
{

}

/*
	//WORK WILL KILL ONE ZOMBIE WITH RAGDOLL ANIM 
	picked_zomb = getZombz();
	picked_zomb[0] animscripts\utility::do_ragdoll_death();

	

*/



testNormalWeapon_string()
{
	weap = self getcurrentweapon();
	S("Weapon:" + getWeaponInfoString(weap));
}




getDumpOfItem(item,iffunction)
{
	S( "##### Start Zombie Variables #####");
	
	
	if(iffunction == false)
		var_names = GetArrayKeys( item );
	else
		var_names = [[item]]();
	for( i = 0; i < var_names.size; i++ )
	{
		key = var_names[i];
		S( key + ":     " + var_names[key] );
		wait 0.5;
	}

	S( "##### End Zombie Variables #####");
}


func_resetScore()
{
	if(isDefined(self.score) && isDefined(self.score_total))
	{
		self maps\_zombiemode_score::minus_to_player_score( self.score ); 
		S("Score ^1Reseted");
	}
	else
		S("error");
}


SlidingText(text_one, text_two)
{
	self.var["ui"]["text_one"] = self createFontString("objective", 2, self);
	self.var["ui"]["text_two"] = self createFontString("objective", 2, self);
	self.var["ui"]["text_one"] setText(text_one);
	self.var["ui"]["text_two"] setText(text_two);
	self.var["ui"]["text_two"] setPoint("CENTER", "BOTTOM", 0, 100);
	self.var["ui"]["text_one"] setPoint("CENTER", "TOP", 0, -100);
	wait .5;
	self.var["ui"]["text_two"] setPoint("CENTER", "TOP", 0, 100, .5);
	self.var["ui"]["text_one"] setPoint("CENTER", "TOP", 0, 75, .5);
	wait 1;
	self.var["ui"]["text_two"] setPoint("CENTER", "TOP", 0, 75, 1);
	self.var["ui"]["text_one"] setPoint("CENTER", "TOP", 0, 100, 1);
	wait 2;
	self.var["ui"]["text_two"] setPoint("LEFT", "TOPRIGHT", 0, 65, .5);
	self.var["ui"]["text_one"] setPoint("RIGHT", "TOPLEFT", 0, 110, .5);
	wait .5;
	self.var["ui"]["text_one"] destroy();
	self.var["ui"]["text_two"] destroy();
}


func_popupMenu(title,string_1,string_2,string_3,icon,icon_w,icon_h)
{
	if(!isDefined(icon))
		icon = "logo_cod2";
	if(!isDefined(icon_w))
		icon_w = 200;
	if(!isDefined(icon_h))
		icon_h = 50;
	
	if(self.var["popup_active"])
	{
		S("View already open.");
		return;
	}
	self.var["popup_active"] = true;
	
	self.menu["ui"]["background"] = self createRectangle("CENTER", "CENTER", 0, 0, 0, 230, (1,0,0), 1, .8, "menu_zombie_lobby_frame_outer_ingame"); 
    self.menu["ui"]["barTop"] = self createRectangle("CENTER", "CENTER", 0, -75, 0, icon_h, (1,1,1), 2, 1, icon); 
	self.menu["ui"]["background"] scaleOverTime(.5, 250, 230);
	self.menu["ui"]["barTop"] scaleOverTime(.5, icon_w, icon_h);
	self func_sound_no_print("zmb_bowie_flourish_start");
	wait .5;
	self.menu["ui"]["text"][3] = self createText(getMenuSetting("font_options"),1.5, 1, title, "CENTER", "CENTER", 0, -45, 0,getMenuSetting("color_text"));
    for( a = 0; a < 3; a ++ )
    {
        self.menu["ui"]["text"][a] = self createText(getMenuSetting("font_options"),1, 2+a, "", "CENTER", "CENTER", 0, 0-10+(a*20), 0,getMenuSetting("color_text"));
	}
	self.menu["ui"]["text"][0] setText(string_1);
	self.menu["ui"]["text"][1] setText(string_2);
	self.menu["ui"]["text"][2] setText(string_3);
	for( a = 0; a < 4; a ++ )
    {
        self.menu["ui"]["text"][a] affectElement("alpha", .1, 1);
        wait .1;
    }
	self.menu["ui"]["text"][4] = self createText(getMenuSetting("font_options"),1.2, 10, "Press ^3F^7 to countine", "CENTER", "CENTER", 45, 0-20+(4*20)+30, 0,getMenuSetting("color_text"));
    self.menu["ui"]["text"][4] affectElement("alpha", .1, 1);
	self.menu["ui"]["text"][4] pulse(true);
	
	while(true)
	{
		if(self useButtonPressed())
		{	
				self func_sound_no_print("evt_perk_deny");	
				self.menu["ui"]["text"][4] pulse(false);
				for( a = 0; a < 5; a ++ )
				{
					self.menu["ui"]["text"][a] destroy();
				}
				self.menu["ui"]["background"] scaleOverTime(.5, 0, 230);
				self.menu["ui"]["barTop"] scaleOverTime(.5, 0, icon_h);
				wait .5;
				self.menu["ui"]["background"] destroy();
				self.menu["ui"]["barTop"] destroy();
				wait .5;
				self.var["popup_active"] = false;
				break;
		}		
		wait .025;
	}
}

///////////////////////////////////////////////////////////////////////////////
//////////////////////MESSAGES MENU////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

func_callMessage(i)
{
	if(!isDefined(self.var["mes_functions"]))
	{
		S("Error");
		return; 
	}	
	else
		self [[self.var["mes_functions"]]](self.var["mes_flash"]+i);
}

func_changeMessagetype()
{
	if(!isDefined(self.var["mes_functions"]) || self.var["mes_functions"] == ::Sbold)
	{
		self.var["mes_functions"] = ::S; 
		self.menu["items"]["main_messages"].name[16] = "Message Type: iprintln";
		S("Message Type: ^2iprintln");
	}
	else if(self.var["mes_functions"] == ::S)
	{
		self.var["mes_functions"] = ::T; 
		self.menu["items"]["main_messages"].name[16] = "Message Type: chat";
		S("Message Type: ^2chat");
	}
	else if(self.var["mes_functions"] == ::T)
	{
		self.var["mes_functions"] = ::Sbold; 
		self.menu["items"]["main_messages"].name[16] = "Message Type: iprintlnbold";
		S("Message Type: ^2iprintlnbold");
	}
	self.menu["ui"]["text"][9] setText(self.menu["items"]["main_messages"].name[16]);
}


func_flashMessages()
{
	if(!isDefined(self.var["mes_flash"]) || self.var["mes_flash"] == "")
	{
		self.var["mes_flash"] = "^F";
		S(getOptionName()+" ^2ON");
	}
	else
	{
		self.var["mes_flash"] = "";
		S(getOptionName()+" ^1OFF");
	}	
}

///////////////////////////////////////////////////////////////////////////////////////
// V0.85
///////////////////////////////////////////////////////////////////////////////////////

zombie_devgui_toggle_ammo()
{
	self endon("stop_ammo");
	for(;;)
	{
			if(self.var["ammo_weap"]==true)
			{	
				if ( self getcurrentweapon() != "none" )
				{
					self setweaponammostock( self getcurrentweapon(), 1337 );
					self setweaponammoclip( self getcurrentweapon(), 1337 );
				}
			}
		wait .1;
	}
}

func_newUnlimitedAmmo()
{
	if(self.var["ammo_weap"] == false)
	{
		self notify("stop_ammo");
		self thread zombie_devgui_toggle_ammo();
		S(getOptionName()+" ^2ON");
		self.var["ammo_weap"] = true;
	}
	else
	{
		self notify("stop_ammo");
		self.var["ammo_weap"] = false;
		S(getOptionName()+ " ^1OFF");
	}
}
func_tel_trace()
{
	self setOrigin(self findTracePosition());
	S("Teleported to Trace Position ^2Successful");
}
func_tel_sky()
{
	self setOrigin(self get_org()+(0,0,100000));
	S("Teleported to Sky ^2Successful");
}
func_tel_ground()
{
	self setOrigin(findGround(self get_org()));
	S("Teleported to Ground ^2Successful");
}
findGround(origin)
{
    return bullettrace(origin,(origin+(0,0,-100000)),false,self)["position"];
}
findTracePosition()
{
	return BulletTrace( self geteye(), ( anglesToForward( self getPlayerAngles() )[0] * 100000000, anglesToForward( self getPlayerAngles() )[1] * 100000000, anglesToForward( self getPlayerAngles() )[2] * 100000000 ), 0, self )[ "position" ];
}
func_tel_near_zombz()
{
	var_zom = get_closest_ai( self.origin, "axis" );
	if(isDefined(var_zom))
	{
		self setOrigin(var_zom.origin);
		self S("Teleported to the nearest ^2Zombie");
	}
	else { self S("^1Error^7: There are no Enemys to Teleport to."); }
}
/*TODO:  BETTER WAY -> get_closest_ai( self.origin, "axis" );
get_closest_enemy()
{
	_client = undefined;
	for ( i = 0;i < getZombz().size;i++ )
	{
		if( isDefined(_client) )
		{
			if( closer( self getTagOrigin( "j_head" ), getZombz()[i] getTagOrigin( "j_head" ), _client getTagOrigin( "j_head" ) ) ) _client = getZombz()[i];
		}
		else _client = getZombz()[i];
	}
	return _client;
}
*/
func_aimbot_classic()
{
	if( self.var["aimbot_classic"] == false )
	{
		self.var["aimbot_classic"] = true;
		self thread func_aimbot();
		S(getOptionName()+ "^2 ON");
	}
	else
	{
		self.var["aimbot_classic"] = false;
		self notify("aimbot_done");
		S(getOptionName()+ "^1 OFF");
	}
}
func_aimbot()
{
	self endon("aimbot_done");
	if(!isDefined(self.var["aimbot_setting_postion"]))
		self.var["aimbot_setting_postion"] = "j_head";
	if(!isDefined(self.var["aimbot_setting_required"]))
		self.var["aimbot_setting_required"] = false;
	while(self.var["aimbot_classic"])
	{
		if(self AdsButtonPressed() || self.var["aimbot_setting_required"])
		{
			self setplayerangles(VectorToAngles((get_closest_ai( self.origin, "axis" ) gettagorigin(self.var["aimbot_setting_postion"]))-(self gettagorigin(self.var["aimbot_setting_postion"]))));
			if(self.var["aimbot_setting_unfair"])
			{
				if(self attackButtonPressed())
					MagicBullet( self getCurrentWeapon(), get_closest_ai( self.origin, "axis" ) gettagorigin(self.var["aimbot_setting_postion"]) + (0,0,5), get_closest_ai( self.origin, "axis" ) gettagorigin(self.var["aimbot_setting_postion"]), self);
				L("unfair -> called()");
			}
		}
		wait .05;
	}
}

func_aimbot_setting_unfair()
{
	if(self.var["aimbot_setting_unfair"] == false)
		self.var["aimbot_setting_unfair"] = true;
	else
		self.var["aimbot_setting_unfair"] = false;
	S(getOptionName()+" ^2"+self.var["aimbot_setting_unfair"]);
}
func_setPostion(i)
{
	self.var["aimbot_setting_postion"] = i; 
	S(getOptionName()+" ^2Seleceted");
}
func_aimbot_setting_required()
{
	if(!isDefined(self.var["aimbot_setting_required"]) || self.var["aimbot_setting_required"] == false)
		self.var["aimbot_setting_required"] = true;
	else
		self.var["aimbot_setting_required"] = false;
	S(getOptionName()+" ^2"+!self.var["aimbot_setting_required"]);
}

///////////////////////////////////////////////////////////////////////////////////////
// V0.9
///////////////////////////////////////////////////////////////////////////////////////


func_colldownToggleTrap()
{
	if( level.mutators["mutator_noTraps"] || self.var["trap_disabled"] )
	{
		S("^1This map does not contain any trap or traps are disabled.");
		return;
	}
	if(level.elec_trap_cooldown_time == 60)
	{
		level.elec_trap_cooldown_time = 0;
	}
	else
		level.elec_trap_cooldown_time = 60;
	
	S("Trap Cooldown Time set to ^2"+level.elec_trap_cooldown_time);
}

func_TrapTimeTrap()
{
	if( level.mutators["mutator_noTraps"] || self.var["trap_disabled"] )
	{
		S("^1This map does not contain any trap or traps are disabled.");
		return;
	}
	
	if(level.elec_trap_time < 100)
		level.elec_trap_time += 10;
	else
		level.elec_trap_time = 0;
	S("Trap Time set to ^2"+level.elec_trap_time);
}
func_trapdisable()
{
	if( level.mutators["mutator_noTraps"])
	{
		S("^1This map does not contain any trap.");
		return;
	}
	if(self.var["trap_disabled"] == false)
	{
		self maps\_zombiemode_traps::disable_traps( GetEntArray( "zombie_trap", "targetname" ) ); 
		S("Traps ^1disabled");
		self.var["trap_disabled"] = true;
	}
	else
		S("^1Traps are already disabled");
}


func_Physical_exlo()
{
	PhysicsExplosionSphere( self.origin, 500, 450, 25 );
	S("Physical Explosion ^2Sended");
}

func_Physical_Cylinder()
{
	PhysicsExplosionCylinder( self.origin, 500, 450, 25 );
	S("Physical Cylinder ^2Sended");
}


func_Physical_drop_of_all()
{
	L("called");
	if(!isDefined(self.var["func_Physical_drop_of_all"]))
	{
		self.var["func_Physical_drop_of_all"] = true;
		S("Physical Drop ^2Send Starting....");
		self setClientDvar("phys_gravity", -400);
		wait 1;
		self setClientDvar("phys_gravity", 0);
		wait 0.5;
		self setClientDvar("phys_gravity", 400);
		wait 3;
		self setClientDvar("phys_gravity", -800);
		wait 4;
		self.var["func_Physical_drop_of_all"] = undefined;
	}
	else
		S("^1Already called wait for end");
}
func_test12()
{
	S("called");
	S("end");
}



