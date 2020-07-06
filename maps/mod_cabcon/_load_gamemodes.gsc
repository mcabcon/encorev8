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
#include maps\mod_cabcon\_load_functions;

///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
// Gamemodes
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////





///////////////////////////////////////////////////////////////////////////////////////
// sharpshooter
// Created by CabCon
///////////////////////////////////////////////////////////////////////////////////////


gamemode_sharpshooter_init()
{
	self create_message("Welcome to ^2Sharpshooter","Created by ^1CabCon");

	//def vars
	
	self.gamemode_sharpshooter_time_max = 45;
	self.gamemode_sharpshooter_time = self.gamemode_sharpshooter_time_max;
	
	self.gamemode_sharpshooter_weapon = "";
	
	
	//core functions
	
	self thread gamemode_sharpshooter_def_weapons();
	self thread gamemode_sharpshooter_core();
	self thread gamemode_sharpshooter_hud();

	//beside functions
	
	self thread func_deleteWeaponTriggers();
	
	
	
	self notify("gamemode_sharpshooter_cycled");
}

gamemode_sharpshooter_def_weapons()
{
	if(!isDefined(self.gamemode_sharpshooter_weaponlist))
	{
		self.gamemode_sharpshooter_weaponlist = strTok("galil_zm commando_zm fnfal_zm dragunov_zm l96a1_zm rpk_zm hk21_zm m72_law_zm china_lake_zm aug_acog_zm hs10_zm spas_zm rottweil72_zm ithaca_zm cz75lh_zm cz75dw_zm spectre_zm pm63_zm mpl_zm mp40_zm mp5k_zm ak74u_zm famas_zm m16_zm"," ");
	}
}

gamemode_sharpshooter_core()
{
	while(true)
	{
		self waittill("gamemode_sharpshooter_cycled"); 
		while(true)
		{
		self.gamemode_sharpshooter_weapon = self.gamemode_sharpshooter_weaponlist[randomint(self.gamemode_sharpshooter_weaponlist.size)];
		if(self getcurrentweapon() != self.gamemode_sharpshooter_weapon)
			continue;
		}
		self TakeWeapon( self getcurrentweapon() );
		self giveWeapon(self.gamemode_sharpshooter_weapon);
		self switchtoweapon(self.gamemode_sharpshooter_weapon);
		S("Weapon cycled to ^2"+self getcurrentweapon());
	}
}

gamemode_sharpshooter_hud()
{
	self.menu["ui"]["title"] = self createText("small",1.5, 1, "WEAPONS CYCLING IN ", "CENTER", "CENTER", 0, 220, 1,(1,1,1));
	self.menu["ui"]["title_value"] = self createValueElement("small", 1.5, 2, self.gamemode_sharpshooter_time, "CENTER", "CENTER", 78, 220, 1,(1,1,1));
	
	self gamemode_sharpshooter_dynamic();
}


gamemode_sharpshooter_dynamic()
{
	L("gamemode_sharpshooter_dynamic called");
	while(true)
	{
		self.menu["ui"]["title_value"] setValue(self.gamemode_sharpshooter_time);
		self.gamemode_sharpshooter_time -= 1;
		if(self.gamemode_sharpshooter_time == -1)
		{
			self.gamemode_sharpshooter_time = self.gamemode_sharpshooter_time_max;
			self notify("gamemode_sharpshooter_cycled");
		}
		wait 1;
	}
}

func_deleteWeaponTriggers()
{
	for( i = 0; i < GetEntArray( "weapon_upgrade", "targetname" ).size; i++ )
	{
		GetEntArray( "weapon_upgrade", "targetname" )[i] disable_trigger();
	}
}











