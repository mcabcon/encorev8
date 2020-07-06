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

#include maps\mod_cabcon\_load_menubase;
#include maps\mod_cabcon\_load_functions;

//Functions
#include maps\_zombiemode_score;
#include maps\mod_cabcon\_load_settings;

runMenuIndex( menu )
{
    self addmenu("main", "EnCoReV8 Zombie-Edition");
    //if verified
    if( self getVerfication() > 0 )
    {
        self addMenuPar("Main Modifications", ::controlMenu, "newMenu", "main_mods");
		self addMenuPar("Fun Mods", ::controlMenu, "newMenu", "main_fun");
        self addMenuPar("Perk Menu", ::controlMenu, "newMenu", "main_perks");
        self addMenuPar("Send Power Ups Menu", ::controlMenu, "newMenu", "main_powerups");
    }
    //if cohost
    if( self getVerfication() > 1 )
    {
        self addMenuPar("Message Menu", ::controlMenu, "newMenu", "main_messages");
        self addMenuPar("Weapons Menu", ::controlMenu, "newMenu", "main_weapons");
        self addMenuPar("Weapons Mods Menu", ::controlMenu, "newMenu", "main_weapons_mods");
        self addMenuPar("Bullets Menu", ::controlMenu, "newMenu", "main_bullets");
        self addMenuPar("Teleport Menu", ::controlMenu, "newMenu", "main_teleport");
        self addMenuPar("Aimbot Menu", ::controlMenu, "newMenu", "main_aimbot");
		self addMenuPar("Entity Menu",::controlMenu, "newMenu", "main_entity");
		self addMenuPar("Visions Menu", ::controlMenu, "newMenu", "main_visions");
		self addMenuPar("SFX Menu", ::controlMenu, "newMenu", "main_sounds");
        self addMenuPar("Enviro Mods", ::controlMenu, "newMenu", "main_enviro");
		self addMenuPar("Graphics Effects Menu", ::controlMenu, "newMenu", "main_effects");
        self addMenuPar("Scoreboard Modifications", ::controlMenu, "newMenu", "main_scoreboard");
    }
    //if host
    if( self getVerfication() > 2 )
    {
		self MENU_HANDLE_developer();
        self addMenuPar("DEVELOPER Panel", ::controlMenu, "newMenu", "main_dev");
        self addMenuPar("Round Menu", ::controlMenu, "newMenu", "main_round");
        self addMenuPar("Host Menu", ::controlMenu, "newMenu", "main_host");
        self addMenuPar("Lobby Menu", ::controlMenu, "newMenu", "main_lobby");
        //self addMenuPar("Clients Menu", ::controlMenu, "newMenu", "playerMenu");
        self addMenuPar("Customize Menu", ::controlMenu, "newMenu", "main_customize");
    }
 
    //any menus that work off of a verification change.
    //should go before the if statment. If you dont then
    //it shall not change when verification is changed.
 
    if( isDefined(menu) )
            return;
	if( isDefined( level.zombie_include_powerups ) )
	{
		self addmenu("main_powerups", "Send Power Ups Menu", "main");
		self addMenuPar("Send Nuke Bomb", ::func_call_powerups, "nuke");
		self addMenuPar("Send Ammo Box", ::func_call_powerups, "full_ammo");
		self addMenuPar("Send Double Points", ::func_call_powerups, "double_points");
		self addMenuPar("Send Insta Kill", ::func_call_powerups, "insta_kill");
		self addMenuPar("Send Carpenter", ::func_call_powerups, "carpenter");
		self addMenuPar("Send Fire Sale", ::func_call_powerups, "fire_sale");
		self addMenuPar("Send Bonfire Sale", ::func_call_powerups, "bonfire_sale");
		self addMenuPar("Send Minigun", ::func_call_powerups, "minigun");
		self addMenuPar("Send Free Perk", ::func_call_powerups, "free_perk");
		self addMenuPar("Send All Revive", ::func_call_powerups, "all_revive");
		self addMenuPar("Send Tesla", ::func_call_powerups, "tesla");
		self addMenuPar("Send Bonus Points", ::func_call_powerups, "bonus_points_player");
		self addMenuPar("Send Bonus Points Team", ::func_call_powerups, "bonus_points_team");
	}
			
	func_create_entity_menu();
	
	
	self addmenu("main_aimbot", "Aimbot Menu", "main");
	self addMenuPar("Toggle Aimbot", ::func_aimbot_classic);
	self addMenuPar("Toggle Unfair Aimbot", ::func_aimbot_setting_unfair);
	self addMenuPar("Toggle Aiming Required", ::func_aimbot_setting_required);
	self addMenuPar("Set Aiming Postion ^2j_head", ::func_setPostion, "j_head");
	
	
	self addmenu("main_entity", "Entity Menu", "main");
	self addMenuPar("Spawn Model with List", ::controlMenu, "newMenu", "main_entity_models");
	self addMenuPar("Spawn Model", ::func_spawnEntityModelView);
	self addMenuPar("Place Model", ::func_placemodel);
	self addMenuPar("Drop Model with Physics", ::func_dropmodel);
	self addMenuPar("Rotate Model", ::controlMenu, "newMenu", "main_entity_rotate");
	self addMenuPar("Delete Model", ::func_deleteentity);
	self addHeadline("Entity System Settings");
	self addMenuPar("Costumize Model Distance", ::controlMenu, "newMenu", "main_entity_modify_settings_distance");
	self addMenuPar("Delete All Entitys", ::entity_deleteCache);
	
	self addmenu("main_entity_rotate", "Rotate Model", "main_entity");
	self addMenuPar("Rotate Angle 1 +", ::rotateCurrentModel, 0, 1);
	self addMenuPar("Rotate Angle 1 -", ::rotateCurrentModel, 0, -1);
	self addMenuPar("Rotate Angle 2 +", ::rotateCurrentModel, 1, 1);
	self addMenuPar("Rotate Angle 2 -", ::rotateCurrentModel, 1, -1);
	self addMenuPar("Rotate Angle 3 +", ::rotateCurrentModel, 2, 1);
	self addMenuPar("Rotate Angle 3 -", ::rotateCurrentModel, 2, -1);
	self addMenuPar("Reset Angles", ::func_resetModelAngles);
	
	self addmenu("main_entity_modify_settings_distance", "Costumize Model Distance", "main_entity");
	self addMenuPar("++", ::func_entity_distance, 20);
	self addMenuPar("--", ::func_entity_distance, (0-20));
	
	
	self addmenu("main_enviro", "Enviro Mods", "main");
	self addMenuPar("Fog Color", ::controlMenu, "newMenu", "main_enviro_fog");
	self addMenuPar("Sun Color", ::controlMenu, "newMenu", "main_enviro_sun");
	
	
	self addmenu("main_enviro_fog", "Fog Color", "main_enviro");
	self addMenuPar("Red Fog", ::func_changeFog, "1 0 0 0");
	self addMenuPar("Blue Fog", ::func_changeFog, "0 0 1 0");
	self addMenuPar("Green Fog", ::func_changeFog, "0 1 0 0");
	self addMenuPar("Yellow Fog", ::func_changeFog, "1 1 0 0");
	self addMenuPar("Cyan Fog", ::func_changeFog, "0 1 1 0");
	self addMenuPar("Orange Fog", ::func_changeFog, "1 0.5 0 0");
	self addMenuPar("Purple Fog", ::func_changeFog, "1 0 1 0");
	self addMenuPar("Black Fog", ::func_changeFog, "0 0 0 0");
	self addMenuPar("White Fog", ::func_changeFog, "1 1 1 1");
	self addMenuPar("Disco Fog", ::func_DiscoFog);
	self addMenuPar("Default", ::func_changeFog, "1 1 1 .7");

	self addmenu("main_enviro_sun", "Sun Color", "main_enviro");
	self addMenuPar("Red Sun", ::func_changeSun, self.function_defaultSize["r_lightTweakSunLight"], "1 0 0");
	self addMenuPar("Blue Sun", ::func_changeSun, self.function_defaultSize["r_lightTweakSunLight"], "0 0 1");
	self addMenuPar("Green Sun", ::func_changeSun, self.function_defaultSize["r_lightTweakSunLight"], "0 1 0");
	self addMenuPar("Yellow Sun", ::func_changeSun, self.function_defaultSize["r_lightTweakSunLight"], "1 1 0");
	self addMenuPar("Cyan Fog", ::func_changeSun,self.function_defaultSize["r_lightTweakSunLight"], "0 1 1");
	self addMenuPar("Orange Fog", ::func_changeSun,self.function_defaultSize["r_lightTweakSunLight"], "1 0.5 0");
	self addMenuPar("Purple Sun", ::func_changeSun, self.function_defaultSize["r_lightTweakSunLight"], "1 0 1");
	self addMenuPar("White Sun", ::func_changeSun, self.function_defaultSize["r_lightTweakSunLight"], "0 0 0");
	self addMenuPar("No Sun", ::func_changeSun, "0", "");
	self addMenuPar("Day Sun", ::func_changeSun, "32", "1 1 1");
	self addMenuPar("Disco Sun", ::func_DiscoSun);
	self addMenuPar("Default", ::func_changeSun, self.function_defaultSize["r_lightTweakSunLight"], self.function_defaultSize["r_lightTweakSunColor"]);
	

	////////////////////////
	self addmenu("main_visions", "Visions Menu", "main");
	self addMenuPar("default", ::func_vision, "default");//w
	self addMenuPar("default_night", ::func_vision, "default_night");
	self addMenuPar("flare", ::func_vision, "flare");
	self addMenuPar("zombie_last_stand", ::func_vision, "zombie_last_stand");
	self addMenuPar("zombie_death", ::func_vision, "zombie_death");
	self addMenuPar("cheat_bw", ::func_vision, "cheat_bw");
	self addMenuPar("cheat_bw_contrast", ::func_vision, "cheat_bw_contrast");
	self addMenuPar("cheat_bw_invert", ::func_vision, "cheat_bw_invert");
	self addMenuPar("cheat_bw_invert_contrast", ::func_vision, "cheat_bw_invert_contrast");
	self addMenuPar("flash_grenade", ::func_vision, "flash_grenade");
	self addMenuPar("infrared", ::func_vision, "infrared");
	self addMenuPar("infrared_snow", ::func_vision, "infrared_snow");
	self addMenuPar("laststand", ::func_vision, "laststand");
	self addMenuPar("low_health", ::func_vision, "low_health");
	self addMenuPar("drown", ::func_vision, "drown");
	self addMenuPar("neutral", ::func_vision, "neutral");
	self addMenuPar("zombie", ::func_vision, "zombie");//w
	self addMenuPar("zombie_asylum", ::func_vision, "zombie_asylum");//w
	self addMenuPar("zombie_black_hole", ::func_vision, "zombie_black_hole");//w
	self addMenuPar("zombie_coast", ::func_vision, "zombie_coast");//w
	self addMenuPar("zombie_coast_2", ::func_vision, "zombie_coast_2");//w
	self addMenuPar("zombie_coast_lighthouse", ::func_vision, "zombie_coast_lighthouse");//w
	self addMenuPar("zombie_coast_poweron", ::func_vision, "zombie_coast_poweron");//w
	self addMenuPar("zombie_coast_rovingeye", ::func_vision, "zombie_coast_rovingeye");//w
	self addMenuPar("zombie_cosmodrome", ::func_vision, "zombie_cosmodrome");//w
	self addMenuPar("zombie_cosmodrome_begin", ::func_vision, "zombie_cosmodrome_begin");//w
	self addMenuPar("zombie_cosmodrome_divetonuke", ::func_vision, "zombie_cosmodrome_divetonuke");//w
	self addMenuPar("zombie_cosmodrome_monkey", ::func_vision, "zombie_cosmodrome_monkey");//w
	self addMenuPar("zombie_cosmodrome_nopower", ::func_vision, "zombie_cosmodrome_nopower");//w
	self addMenuPar("zombie_cosmodrome_poweron", ::func_vision, "zombie_cosmodrome_poweron");//w
	self addMenuPar("zombie_cosmodrome_powerup", ::func_vision, "zombie_cosmodrome_powerup");//w
	self addMenuPar("zombie_death", ::func_vision, "zombie_death");//w
	self addMenuPar("zombie_factory", ::func_vision, "zombie_factory");//w
	self addMenuPar("zombie_frontend_default", ::func_vision, "zombie_frontend_default");//w
	self addMenuPar("zombie_frontend_menus", ::func_vision, "zombie_frontend_menus");//w
	self addMenuPar("zombie_humangun_player_hit", ::func_vision, "zombie_humangun_player_hit");//w
	self addMenuPar("zombie_humangun_upgraded_player_hit", ::func_vision, "zombie_humangun_upgraded_player_hit");//w
	self addMenuPar("zombie_last_stand", ::func_vision, "zombie_last_stand");//w
	self addMenuPar("zombie_moon", ::func_vision, "zombie_moon");//w
	self addMenuPar("zombie_moon_black_hole", ::func_vision, "zombie_moon_black_hole");//w
	self addMenuPar("zombie_moon_hellearth", ::func_vision, "zombie_moon_hellearth");//w
	self addMenuPar("zombie_moonbiodome", ::func_vision, "zombie_moonbiodome");//w
	self addMenuPar("zombie_moonhanger18", ::func_vision, "zombie_moonhanger18");//w
	self addMenuPar("zombie_mooninterior", ::func_vision, "zombie_mooninterior");//w
	self addMenuPar("zombie_moontunnels", ::func_vision, "zombie_moontunnels");//w
	self addMenuPar("zombie_mountain", ::func_vision, "zombie_mountain");//w
	self addMenuPar("zombie_neutral", ::func_vision, "zombie_neutral");//w
	self addMenuPar("zombie_pentagon", ::func_vision, "zombie_pentagon");//w
	self addMenuPar("zombie_pentagon_electrician", ::func_vision, "zombie_pentagon_electrician");//w
	self addMenuPar("zombie_pentagon_lab", ::func_vision, "zombie_pentagon_lab");//w
	self addMenuPar("zombie_pentagon_offices_poweroff", ::func_vision, "zombie_pentagon_offices_poweroff");//w
	self addMenuPar("zombie_pentagon_warroom", ::func_vision, "zombie_pentagon_warroom");//w
	self addMenuPar("zombie_prototype", ::func_vision, "zombie_prototype");//w
	self addMenuPar("zombie_sumpf", ::func_vision, "zombie_sumpf");//w
	self addMenuPar("zombie_sumpf_dogs", ::func_vision, "zombie_sumpf_dogs");//w
	self addMenuPar("zombie_temple", ::func_vision, "zombie_temple");//w
	self addMenuPar("zombie_temple_caves", ::func_vision, "zombie_temple_caves");//w
	self addMenuPar("zombie_temple_eclipse", ::func_vision, "zombie_temple_eclipse");//w
	self addMenuPar("zombie_temple_eclipsecave", ::func_vision, "zombie_temple_eclipsecave");//w
	self addMenuPar("zombie_theater", ::func_vision, "zombie_theater");//w
	self addMenuPar("zombie_theater_eroom_asylum", ::func_vision, "zombie_theater_eroom_asylum");//w
	self addMenuPar("zombie_theater_eroom_girlnew", ::func_vision, "zombie_theater_eroom_girlnew");//w
	self addMenuPar("zombie_theater_eroom_girlold", ::func_vision, "zombie_theater_eroom_girlold");//w
	self addMenuPar("zombie_theater_erooms_pentagon", ::func_vision, "zombie_theater_erooms_pentagon");//w
	self addMenuPar("zombie_turned", ::func_vision, "zombie_turned");//w
	self addMenuPar("zombietron_afternoon", ::func_vision, "zombietron_afternoon");//w
	self addMenuPar("zombietron_afternoon_death", ::func_vision, "zombietron_afternoon_death");//w
	self addMenuPar("zombietron_day", ::func_vision, "zombietron_day");//w
	self addMenuPar("zombietron_evening", ::func_vision, "zombietron_evening");//w
	self addMenuPar("zombietron_evening_rooftop", ::func_vision, "zombietron_evening_rooftop");//w
	self addMenuPar("zombietron_morning", ::func_vision, "zombietron_morning");//w
	self addMenuPar("zombietron_morning_island", ::func_vision, "zombietron_morning_island");//w

	self addmenu("main_sounds", "SFX Menu", "main");
	self addMenuPar("Toggle Menu Sound Effects", ::setTogglerFunction,"sound_in_menu");
	self addMenuPar("Play Music", ::controlMenu, "newMenu", "main_sounds_music");
	self addMenuPar("Play Dialogs", ::controlMenu, "newMenu", "main_sounds_dialog");
	self addMenuPar("Play Zombie SFX", ::controlMenu, "newMenu", "main_sounds_common_zmb");
	self addMenuPar("Play Global Step SFX", ::controlMenu, "newMenu", "main_sounds_common_sfx");
	self addMenuPar("Play Global Zombie SFX", ::controlMenu, "newMenu", "main_sounds_common_zm_sfx");
	self addMenuPar("Play Global Windows SFX", ::controlMenu, "newMenu", "main_sounds_common_windows");
	self addMenuPar("Play Global Perk Machines SFX", ::controlMenu, "newMenu", "main_sounds_common_perks");
	self addMenuPar("Play Global Magicbox SFX", ::controlMenu, "newMenu", "main_sounds_common_magic_box");
	self addMenuPar("Play Global Traps SFX", ::controlMenu, "newMenu", "main_sounds_common_traps");
	self addMenuPar("Play Global Weapons SFX", ::controlMenu, "newMenu", "main_sounds_common_weapons");
	self addMenuPar("Play Global Power Ups SFX", ::controlMenu, "newMenu", "main_sounds_common_magic_powerups");
	self addMenuPar("Play MISC SFX", ::controlMenu, "newMenu", "main_sounds_common_misc");
	if(get_map()== "zombie_theater")
	{
		self addMenuPar("Play Easter Egg Voice 1", ::func_sound, "vox_zmb_egg_00");//w
		self addMenuPar("Play Easter Egg Voice 2", ::func_sound, "vox_zmb_egg_01");//w
		self addMenuPar("Play Easter Egg Voice 3", ::func_sound, "vox_zmb_egg_02");//w
		self addMenuPar("Play Easter Egg Voice 4", ::func_sound, "vox_zmb_egg_03");//w
		self addMenuPar("Play Easter Egg Voice 5", ::func_sound, "vox_zmb_egg_04");//T
	}
	
	self addmenu("main_sounds_dialog", "Play Dialogs", "main_sounds");
	self addMenuPar("Nuke", ::func_sound_dialog, "powerup", "nuke");
	self addMenuPar("Box Move", ::func_sound_dialog, "general", "box_move");
	self addMenuPar("Turn the Power on!", ::func_sound_dialog, "general", "intro");
	self addMenuPar("Perk", ::func_sound_dialog, "perk", "specialty_armorvest");
	self addMenuPar("Melee", ::func_sound_dialog, "kill", "melee");
	self addMenuPar("Raygun", ::func_sound_dialog, "kill", "raygun");
	self addMenuPar("Raygun Pickup", ::func_sound_dialog, "weapon_pickup", "raygun");
	self addMenuPar("Easter Egg", ::func_sound_dialog, "eggs", "room_screen");
	self addMenuPar("Zombies", ::func_sound_dialog, "zombie", "ambient");
	self addMenuPar("Death", ::func_sound_dialog, "boss_zombie", "death");
	
	self addmenu("main_sounds_music", "Play Sound Menu", "main_sounds");
	//Shared
	self addHeadline("General");
	self addMenuPar("Round Start SFX", ::func_sound, "mus_zombie_round_start");
	self addMenuPar("Round Over SFX", ::func_sound, "mus_zombie_round_over");
	self addMenuPar("Splash Screen SFX", ::func_sound, "mus_zombie_splash_screen");
	self addMenuPar("Game Over Song", ::func_sound, "mus_zombie_game_over");
	self addMenuPar("Dog Round Start SFX", ::func_sound, "mus_zombie_dog_start");
	self addMenuPar("Dog Round End SFX", ::func_sound, "mus_zombie_dog_end");
	//Zombie Drome
	self addHeadline("Vendors");
	self addMenuPar("Revive Jingle", ::func_sound, "mus_perks_revive_jingle");
	self addMenuPar("Jugganog Jingle", ::func_sound, "mus_perks_jugganog_jingle");
	self addMenuPar("Doubletap Jingle", ::func_sound, "mus_perks_doubletap_jingle");
	self addMenuPar("Speed Cola Jingle", ::func_sound, "mus_perks_speed_jingle");
	self addMenuPar("Packer Punch jingle", ::func_sound, "mus_perks_packa_jingle");
	self addMenuPar("Revive Sting Song", ::func_sound, "mus_perks_revive_sting");
	self addMenuPar("Jugganog Sting Song", ::func_sound, "mus_perks_jugganog_sting");
	self addMenuPar("Doubletap Sting Song", ::func_sound, "mus_perks_doubletap_sting");
	self addMenuPar("Speed Cola Sting Song", ::func_sound, "mus_perks_speed_sting");
	self addMenuPar("Packer Punch Sting Song", ::func_sound, "mus_perks_packa_sting");
	self addMenuPar("Underscore Song", ::func_sound, "mus_zombiedrome_underscore");
	//Zombie FireSale
	self addMenuPar("Fire Sale Song", ::func_sound, "mus_fire_sale");
	//Packapunch Special Jingle for Pentagon
	self addMenuPar("Pentagon Packer Punch Song", ::func_sound, "mus_packapunch_special");
	//Zombie Pentagon
	self addMenuPar("Pentagon Elevator Music", ::func_sound, "mus_elevator_muzak");
	self addMenuPar("Pentagon Easter Egg Song", ::func_sound, "mus_egg_mature");
	self addMenuPar("Pentagon Easter Egg Safe Song", ::func_sound, "mus_egg_safe");
	//Zombie Theater
	self addMenuPar("Zombie Theater Easter Egg Song", ::func_sound, "mus_egg");
	self addMenuPar("Rise Radio Song WTF", ::func_sound, "wtf");
	self addMenuPar("Rise Radio Song Abramacabre", ::func_sound, "abra_macabre");
	self addMenuPar("Rise Radio Song UHF", ::func_sound, "uhf");
	self addMenuPar("Rise Radio Song Dusk", ::func_sound, "dusk");
	self addMenuPar("Rise Radio Song Underwater", ::func_sound, "underwater");
	self addMenuPar("Rise Radio Song Slasher Flick", ::func_sound, "slasher_flick");
	self addMenuPar("Rise Radio Song Maskwalk", ::func_sound, "maskwalk");
	self addMenuPar("Rise Radio Song Sand", ::func_sound, "sand");
	self addMenuPar("Rise Radio Song Temple", ::func_sound, "temple");


	//Zombie Vocals
	//Universal
	self addmenu("main_sounds_common_zmb", "Play Sound Menu", "main_sounds");
	self addMenuPar("Zombie Vocals", ::func_sound, "zmb_elec_vocals");
	self addMenuPar("zmb_vocals_zombie_ambience", ::func_sound, "zmb_vocals_zombie_ambience");
	self addMenuPar("zmb_vocals_zombie_teardown", ::func_sound, "zmb_vocals_zombie_teardown");
	self addMenuPar("zmb_vocals_zombie_attack", ::func_sound, "zmb_vocals_zombie_attack");
	self addMenuPar("zmb_vocals_zombie_sprint", ::func_sound, "zmb_vocals_zombie_sprint");
	self addMenuPar("zmb_vocals_zombie_taunt", ::func_sound, "zmb_vocals_zombie_taunt");
	self addMenuPar("zmb_vocals_zombie_death", ::func_sound, "zmb_vocals_zombie_death");
	self addMenuPar("zmb_vocals_zombie_behind", ::func_sound, "zmb_vocals_zombie_behind");
	self addMenuPar("zmb_vocals_zombie_crawler", ::func_sound, "zmb_vocals_zombie_crawler");
	//Quad Zombies
	self addHeadline("Quad Zombies");
	self addMenuPar("zmb_vocals_quad_ambience", ::func_sound, "zmb_vocals_quad_ambience");
	self addMenuPar("zmb_vocals_quad_sprint", ::func_sound, "zmb_vocals_quad_sprint");
	self addMenuPar("zmb_vocals_quad_attack", ::func_sound, "zmb_vocals_quad_attack");
	self addMenuPar("zmb_vocals_quad_death", ::func_sound, "zmb_vocals_quad_death");
	self addMenuPar("zmb_vocals_quad_behind", ::func_sound, "zmb_vocals_quad_behind");
	self addMenuPar("zmb_vocals_quad_spawn", ::func_sound, "zmb_vocals_quad_spawn");
	//Thief Zombies
	self addHeadline("Thief Zombies");
	self addMenuPar("zmb_vocals_thief_ambience", ::func_sound, "zmb_vocals_thief_ambience");
	self addMenuPar("zmb_vocals_thief_sprint", ::func_sound, "zmb_vocals_thief_sprint");
	self addMenuPar("zmb_vocals_thief_steal", ::func_sound, "zmb_vocals_thief_steal");
	self addMenuPar("zmb_vocals_thief_death", ::func_sound, "zmb_vocals_thief_death");
	self addMenuPar("zmb_vocals_thief_anger", ::func_sound, "zmb_vocals_thief_anger");
	//Engineer Zombies
	self addHeadline("Engineer Zombies");
	self addMenuPar("zmb_engineer_vocals_amb", ::func_sound, "zmb_engineer_vocals_amb");
	self addMenuPar("zmb_engineer_vocals_hit", ::func_sound, "zmb_engineer_vocals_hit");
	self addMenuPar("zmb_engineer_vocals_attack", ::func_sound, "zmb_engineer_vocals_attack");
	self addMenuPar("zmb_engineer_vocals_death", ::func_sound, "zmb_engineer_vocals_death");
	self addMenuPar("zmb_boss_vocals_behind", ::func_sound, "zmb_boss_vocals_behind");
	//Hellhounds
	self addHeadline("Hellhounds");
	self addMenuPar("aml_dog_attack_jump", ::func_sound, "aml_dog_attack_jump");
	self addMenuPar("zmb_hellhound_vocals_bite", ::func_sound, "zmb_hellhound_vocals_bite");
	self addMenuPar("zmb_hellhound_vocals_amb", ::func_sound, "zmb_hellhound_vocals_amb");
	self addMenuPar("zmb_hellhound_vocals_close", ::func_sound, "zmb_hellhound_vocals_close");
	self addMenuPar("zmb_hellhound_vocals_death", ::func_sound, "zmb_hellhound_vocals_death");
	self addMenuPar("aml_dog_bark", ::func_sound, "aml_dog_bark");
	self addMenuPar("aml_dog_run_start", ::func_sound, "aml_dog_run_start");
	self addMenuPar("aml_dog_growl", ::func_sound, "aml_dog_growl");
	self addMenuPar("aml_dog_idle_look", ::func_sound, "aml_dog_idle_look");
	
	//Zombie Foley/SFX
	//Universal
	self addmenu("main_sounds_common_sfx", "Play Sound Menu", "main_sounds");
	self addMenuPar("zmb_zombie_head_gib", ::func_sound, "zmb_zombie_head_gib");
	self addMenuPar("zmb_death_gibs", ::func_sound, "zmb_death_gibs");
	self addMenuPar("fly_step_zombie_default", ::func_sound, "fly_step_zombie_default");
	self addMenuPar("fly_step_zombie_bark", ::func_sound, "fly_step_zombie_bark");
	self addMenuPar("fly_step_zombie_brick", ::func_sound, "fly_step_zombie_brick");
	self addMenuPar("fly_step_zombie_carpet", ::func_sound, "fly_step_zombie_carpet");
	self addMenuPar("fly_step_zombie_cloth", ::func_sound, "fly_step_zombie_cloth");
	self addMenuPar("fly_step_zombie_concrete", ::func_sound, "fly_step_zombie_concrete");
	self addMenuPar("fly_step_zombie_dirt", ::func_sound, "fly_step_zombie_dirt");
	self addMenuPar("fly_step_zombie_flesh", ::func_sound, "fly_step_zombie_flesh");
	self addMenuPar("fly_step_zombie_foliage", ::func_sound, "fly_step_zombie_foliage");
	self addMenuPar("fly_step_zombie_glass", ::func_sound, "fly_step_zombie_glass");
	self addMenuPar("fly_step_zombie_grass", ::func_sound, "fly_step_zombie_grass");
	self addMenuPar("fly_step_zombie_gravel", ::func_sound, "fly_step_zombie_gravel");
	self addMenuPar("fly_step_zombie_ice", ::func_sound, "fly_step_zombie_ice");
	self addMenuPar("fly_step_zombie_metal", ::func_sound, "fly_step_zombie_metal");
	self addMenuPar("fly_step_zombie_mud", ::func_sound, "fly_step_zombie_mud");
	self addMenuPar("fly_step_zombie_paper", ::func_sound, "fly_step_zombie_paper");
	self addMenuPar("fly_step_zombie_rock", ::func_sound, "fly_step_zombie_rock");
	self addMenuPar("fly_step_zombie_sand", ::func_sound, "fly_step_zombie_sand");
	self addMenuPar("fly_step_zombie_snow", ::func_sound, "fly_step_zombie_snow");
	self addMenuPar("fly_step_zombie_water", ::func_sound, "fly_step_zombie_water");
	self addMenuPar("fly_step_zombie_wood", ::func_sound, "fly_step_zombie_wood");
	self addMenuPar("fly_step_zombie_asphalt", ::func_sound, "fly_step_zombie_asphalt");
	self addMenuPar("fly_step_zombie_ceramic", ::func_sound, "fly_step_zombie_ceramic");
	self addMenuPar("fly_step_zombie_plastic", ::func_sound, "fly_step_zombie_plastic");
	self addMenuPar("fly_step_zombie_rubber", ::func_sound, "fly_step_zombie_rubber");
	self addMenuPar("fly_step_zombie_cushion", ::func_sound, "fly_step_zombie_cushion");
	self addMenuPar("fly_step_zombie_fruit", ::func_sound, "fly_step_zombie_fruit");
	self addMenuPar("fly_step_zombie_paintedmetal", ::func_sound, "fly_step_zombie_paintedmetal");
	self addMenuPar("fly_cloth_zombie", ::func_sound, "fly_cloth_zombie");
	self addMenuPar("fly_gear_zombie", ::func_sound, "fly_gear_zombie");
	
	//Standard Zombies
	self addmenu("main_sounds_common_zm_sfx", "Play Sound Menu", "main_sounds");
	self addMenuPar("Zombie Spawn", ::func_sound, "zmb_zombie_spawn");
	self addMenuPar("fly_fall_zombie", ::func_sound, "fly_fall_zombie");
	self addMenuPar("fly_step_zombie", ::func_sound, "fly_step_zombie");
	self addMenuPar("fly_step_zombie_sweetner", ::func_sound, "fly_step_zombie_sweetner");
	self addMenuPar("zmb_attack_whoosh", ::func_sound, "zmb_attack_whoosh");
	//Quad Zombies
	self addHeadline("Quad Zombies");
	self addMenuPar("Quad Zombie Spawn", ::func_sound, "zmb_quad_spawn");
	self addMenuPar("fly_step_crawler", ::func_sound, "fly_step_crawler");
	self addMenuPar("fly_step_quad_l", ::func_sound, "fly_step_quad_l");
	self addMenuPar("fly_step_quad_r", ::func_sound, "fly_step_quad_r");
	self addMenuPar("zmb_quad_explo", ::func_sound, "zmb_quad_explo");
	self addMenuPar("zmb_quad_roof_hit", ::func_sound, "zmb_quad_roof_hit");
	self addMenuPar("zmb_quad_roof_break", ::func_sound, "zmb_quad_roof_break");
	self addMenuPar("zmb_quad_roof_break_land", ::func_sound, "zmb_quad_roof_break_land");
	self addMenuPar("zmb_quad_roof_break_land", ::func_sound, "zmb_quad_roof_break_land");
	//Engineer Zombies
	self addHeadline("Engineer Zombies");
	self addMenuPar("Engineer Zombie Spawn", ::func_sound, "zmb_engineer_spawn");
	self addMenuPar("zmb_engineer_death_bells", ::func_sound, "zmb_engineer_death_bells");
	self addMenuPar("fly_step_engineer", ::func_sound, "fly_step_engineer");
	self addMenuPar("zmb_engineer_headbutt", ::func_sound, "zmb_engineer_headbutt");
	self addMenuPar("zmb_engineer_headbang", ::func_sound, "zmb_engineer_headbang");
	self addMenuPar("zmb_engineer_pipebang", ::func_sound, "zmb_engineer_pipebang");
	self addMenuPar("zmb_engineer_handbang", ::func_sound, "zmb_engineer_handbang");
	self addMenuPar("zmb_engineer_groundbang", ::func_sound, "zmb_engineer_groundbang");
	self addMenuPar("zmb_engineer_groundbang_sweet", ::func_sound, "zmb_engineer_groundbang_sweet");
	self addMenuPar("zmb_engineer_groundbang_l", ::func_sound, "zmb_engineer_groundbang_l");
	self addMenuPar("zmb_engineer_groundbang_r", ::func_sound, "zmb_engineer_groundbang_r");
	self addMenuPar("zmb_engineer_whoosh", ::func_sound, "zmb_engineer_whoosh");
	//Hellhounds
	self addHeadline("Hellhounds");
	self addMenuPar("zmb_hellhound_bolt", ::func_sound, "zmb_hellhound_bolt");
	self addMenuPar("Hellhounds Spawn", ::func_sound, "zmb_hellhound_spawn");
	self addMenuPar("zmb_hellhound_prespawn", ::func_sound, "zmb_hellhound_prespawn");
	self addMenuPar("zmb_hellhound_spawn_flux_l", ::func_sound, "zmb_hellhound_spawn_flux_l");
	self addMenuPar("zmb_hellhound_spawn_flux_r", ::func_sound, "zmb_hellhound_spawn_flux_r");
	self addMenuPar("zmb_hellhound_explode", ::func_sound, "zmb_hellhound_explode");
	self addMenuPar("zmb_hellhound_loop_fire", ::func_sound, "zmb_hellhound_loop_fire");
	self addMenuPar("zmb_hellhound_loop_breath", ::func_sound, "zmb_hellhound_loop_breath");
	self addMenuPar("fly_dog_step_run_default", ::func_sound, "fly_dog_step_run_default");
	self addMenuPar("zmb_dog_round_start", ::func_sound, "zmb_dog_round_start");
	
	//Windows
	//Boards
	self addmenu("main_sounds_common_windows", "Play Sound Menu", "main_sounds");
	self addMenuPar("zmb_boards_float", ::func_sound, "zmb_boards_float");
	self addMenuPar("zmb_board_slam", ::func_sound, "zmb_board_slam");
	self addMenuPar("zmb_break_boards", ::func_sound, "zmb_break_boards");
	self addMenuPar("zmb_repair_boards", ::func_sound, "zmb_repair_boards");
	//Metal Bars
	self addHeadline("Metal Bars");
	self addMenuPar("zmb_bar_pull", ::func_sound, "zmb_bar_pull");
	self addMenuPar("zmb_bar_break", ::func_sound, "zmb_bar_break");
	self addMenuPar("zmb_bar_drop", ::func_sound, "zmb_bar_drop");
	self addMenuPar("zmb_bar_bend", ::func_sound, "zmb_bar_bend");
	self addMenuPar("zmb_bar_repair", ::func_sound, "zmb_bar_repair");
	self addMenuPar("zmb_metal_repair", ::func_sound, "zmb_metal_repair");
	//Doors
	self addHeadline("Doors");
	self addMenuPar("zmb_couch_slam", ::func_sound, "zmb_couch_slam");
	self addMenuPar("zmb_lightning_l", ::func_sound, "zmb_lightning_l");
	self addMenuPar("zmb_lightning_r", ::func_sound, "zmb_lightning_r");
	self addMenuPar("zmb_door_slide_open", ::func_sound, "zmb_door_slide_open");
	self addMenuPar("zmb_rckt_door_slide_open", ::func_sound, "zmb_rckt_door_slide_open");
	self addMenuPar("zmb_door_wood_open", ::func_sound, "zmb_door_wood_open");
	self addMenuPar("zmb_door_fence_open", ::func_sound, "zmb_door_fence_open");
	self addMenuPar("zmb_wooden_door_fall", ::func_sound, "zmb_wooden_door_fall");
	self addMenuPar("zmb_lab_door_slide", ::func_sound, "zmb_lab_door_slide");
	self addMenuPar("zmb_window_grate_slide", ::func_sound, "zmb_window_grate_slide");
	
	//Perk Machines
	self addmenu("main_sounds_common_perks", "Play Sound Menu", "main_sounds");
	self addMenuPar("evt_electrical_surge", ::func_sound, "evt_electrical_surge");
	self addMenuPar("evt_perk_deny", ::func_sound, "evt_perk_deny"); //Menu use
	self addMenuPar("evt_bottle_dispense", ::func_sound, "evt_bottle_dispense");
	self addMenuPar("evt_perk_bottle_open", ::func_sound, "evt_perk_bottle_open");
	self addMenuPar("evt_perk_swallow", ::func_sound, "evt_perk_swallow");
	self addMenuPar("evt_belch", ::func_sound, "evt_belch");
	self addMenuPar("evt_bottle_break", ::func_sound, "evt_bottle_break");
	self addMenuPar("zmb_perks_packa_upgrade", ::func_sound, "zmb_perks_packa_upgrade");
	self addMenuPar("zmb_perks_packa_ready", ::func_sound, "zmb_perks_packa_ready");
	self addMenuPar("zmb_perks_packa_ticktock", ::func_sound, "zmb_perks_packa_ticktock"); //Menu Scrolling
	self addMenuPar("zmb_perks_packa_deny", ::func_sound, "zmb_perks_packa_deny");
	self addMenuPar("zmb_perks_machine_loop", ::func_sound, "zmb_perks_machine_loop");
	self addMenuPar("zmb_perks_broken_jingle", ::func_sound, "zmb_perks_broken_jingle");
	self addMenuPar("zmb_perks_power_on", ::func_sound, "zmb_perks_power_on");// Mode Select
	self addMenuPar("zmb_perks_packa_loop", ::func_sound, "zmb_perks_packa_loop");
	self addMenuPar("zmb_perks_packa_knuckle_0", ::func_sound, "zmb_perks_packa_knuckle_0");
	self addMenuPar("zmb_perks_packa_knuckle_1", ::func_sound, "zmb_perks_packa_knuckle_1");
	
	//Magic Box
	self addmenu("main_sounds_common_magic_box", "Play Sound Menu", "main_sounds");
	self addMenuPar("Music Box Music", ::func_sound, "zmb_music_box");
	self addMenuPar("zmb_box_move", ::func_sound, "zmb_box_move");
	self addMenuPar("zmb_box_poof", ::func_sound, "zmb_box_poof");
	self addMenuPar("zmb_whoosh", ::func_sound, "zmb_whoosh");
	self addMenuPar("zmb_laugh_child", ::func_sound, "zmb_laugh_child");
	self addMenuPar("zmb_lid_open", ::func_sound, "zmb_lid_open");
	self addMenuPar("zmb_lid_close", ::func_sound, "zmb_lid_close");
	self addMenuPar("zmb_box_poof_land", ::func_sound, "zmb_box_poof_land");
	self addMenuPar("zmb_box_poof_land_flux_l", ::func_sound, "zmb_box_poof_land_flux_l");
	self addMenuPar("zmb_box_poof_land_flux_r", ::func_sound, "zmb_box_poof_land_flux_r");
	self addMenuPar("zmb_ann_vox_laugh_l", ::func_sound, "zmb_ann_vox_laugh_l");
	self addMenuPar("zmb_ann_vox_laugh_r", ::func_sound, "zmb_ann_vox_laugh_r");
	//Purchasing
	self addHeadline("Purchasing");
	self addMenuPar("Cha Ching", ::func_sound, "zmb_cha_ching");
	self addMenuPar("zmb_no_cha_ching", ::func_sound, "zmb_no_cha_ching");
	self addMenuPar("zmb_weap_wall", ::func_sound, "zmb_weap_wall");
	
	//Powerups
	//Spawn
	self addmenu("main_sounds_common_magic_powerups", "Play Sound Menu", "main_sounds");
	self addHeadline("Spawn");
	self addMenuPar("zmb_spawn_powerup", ::func_sound, "zmb_spawn_powerup");
	self addMenuPar("zmb_spawn_powerup_loop", ::func_sound, "zmb_spawn_powerup_loop");
	//Pickup
	self addHeadline("Pickup");
	self addMenuPar("zmb_powerup_grabbed", ::func_sound, "zmb_powerup_grabbed");
	self addMenuPar("zmb_powerup_grabbed_3p", ::func_sound, "zmb_powerup_grabbed_3p");
	//Powers
	self addHeadline("Powers");
	self addMenuPar("zmb_insta_kill", ::func_sound, "zmb_insta_kill");
	self addMenuPar("zmb_insta_kill_loop", ::func_sound, "zmb_insta_kill_loop");
	self addMenuPar("zmb_full_ammo", ::func_sound, "zmb_full_ammo");
	self addMenuPar("evt_nuked", ::func_sound, "evt_nuked");
	self addMenuPar("evt_nuke_flash", ::func_sound, "evt_nuke_flash");
	self addMenuPar("evt_dew_80hz", ::func_sound, "evt_dew_80hz");
	self addMenuPar("evt_carpenter", ::func_sound, "evt_carpenter");
	self addMenuPar("evt_carpenter_end", ::func_sound, "evt_carpenter_end");
	self addMenuPar("zmb_double_point_loop", ::func_sound, "zmb_double_point_loop");
	self addMenuPar("zmb_points_loop_off", ::func_sound, "zmb_points_loop_off");
	
	self addmenu("main_sounds_common_misc", "Play Sound Menu", "main_sounds");
	//MISC
	self addMenuPar("evt_challenge_complete", ::func_sound, "evt_challenge_complete");
	self addMenuPar("evt_laststand_loop", ::func_sound, "evt_laststand_loop");
	//Deathcard
	self addHeadline("Deathcard");
	self addMenuPar("evt_death_card", ::func_sound, "evt_death_card");
	self addMenuPar("evt_death_card_loop", ::func_sound, "evt_death_card_loop");
	self addMenuPar("evt_death_card_voice_loop", ::func_sound, "evt_death_card_voice_loop");
	//Meteor
	self addHeadline("Meteor");
	self addMenuPar("zmb_meteor_loop", ::func_sound, "zmb_meteor_loop");
	self addMenuPar("zmb_meteor_activate", ::func_sound, "zmb_meteor_activate");
	//Battery
	self addHeadline("Battery");
	self addMenuPar("zmb_battery_pickup", ::func_sound, "zmb_battery_pickup");
	self addMenuPar("zmb_battery_insert", ::func_sound, "zmb_battery_insert");
	//Switch
	self addHeadline("Switch");
	self addMenuPar("zmb_switch_flip", ::func_sound, "zmb_switch_flip");
	self addMenuPar("amb_sparks_l_b", ::func_sound, "amb_sparks_l_b");
	self addMenuPar("amb_sparks_r_b", ::func_sound, "amb_sparks_r_b");
	self addMenuPar("amb_sparks_l", ::func_sound, "amb_sparks_l");
	self addMenuPar("amb_sparks_r", ::func_sound, "amb_sparks_r");
	self addMenuPar("amb_sparks_l_end", ::func_sound, "amb_sparks_l_end");
	self addMenuPar("amb_sparks_r_end", ::func_sound, "amb_sparks_r_end");
	self addMenuPar("amb_sparks", ::func_sound, "amb_sparks");
	self addMenuPar("amb_sparks_loop", ::func_sound, "amb_sparks_loop");
	self addMenuPar("zmb_turn_on", ::func_sound, "zmb_turn_on");
	self addMenuPar("zmb_circuit", ::func_sound, "zmb_circuit");
	self addMenuPar("evt_generator_surge", ::func_sound, "evt_generator_surge");
	//Player Swiped
	self addMenuPar("evt_player_swiped", ::func_sound, "evt_player_swiped");
	//Navigation
	self addHeadline("UI Navigation");
	self addMenuPar("uin_navigation_click", ::func_sound, "uin_navigation_click");
	self addMenuPar("uin_navigation_over", ::func_sound, "uin_navigation_over");
	self addMenuPar("uin_navigation_slider", ::func_sound, "uin_navigation_slider");
	self addMenuPar("uin_navigation_submenu_over", ::func_sound, "uin_navigation_submenu_over");
	self addMenuPar("uin_navigation_backout", ::func_sound, "uin_navigation_backout");
	self addMenuPar("uin_navigation_zoom_in", ::func_sound, "uin_navigation_zoom_in");
	self addMenuPar("uin_navigation_zoom_out", ::func_sound, "uin_navigation_zoom_out");
	self addMenuPar("uin_navigation_sys_open", ::func_sound, "uin_navigation_sys_open");
	self addMenuPar("uin_navigation_sys_close", ::func_sound, "uin_navigation_sys_close");
	self addMenuPar("uin_navigation_menu_sm_open", ::func_sound, "uin_navigation_menu_sm_open");
	self addMenuPar("uin_navigation_menu_sm_close", ::func_sound, "uin_navigation_menu_sm_close");
	self addMenuPar("uin_navigation_menu_lg_open", ::func_sound, "uin_navigation_menu_lg_open");
	self addMenuPar("uin_navigation_menu_lg_close", ::func_sound, "uin_navigation_menu_lg_close");
	//Timers
	self addMenuPar("uin_timer_wager_beep", ::func_sound, "uin_timer_wager_beep");
	self addMenuPar("uin_timer_wager_last_beep", ::func_sound, "uin_timer_wager_last_beep");
	//Lobby
	self addMenuPar("uin_lobby_join", ::func_sound, "uin_lobby_join");
	self addMenuPar("uin_lobby_leave", ::func_sound, "uin_lobby_leave");
	self addMenuPar("uin_lobby_wager", ::func_sound, "uin_lobby_wager");
	//Options
	self addMenuPar("uin_options_slider", ::func_sound, "uin_options_slider");
	self addMenuPar("uin_options_slider_RS", ::func_sound, "uin_options_slider_RS");
	self addMenuPar("uin_objective_updated", ::func_sound, "uin_objective_updated");
	self addMenuPar("uin_objective_completed", ::func_sound, "uin_objective_completed");
	self addMenuPar("uin_unlock_window", ::func_sound, "uin_unlock_window");
	self addMenuPar("uin_aar_unlock", ::func_sound, "uin_aar_unlock");
	//Alerts
	self addMenuPar("uin_alert_lockon_start", ::func_sound, "uin_alert_lockon_start");
	self addMenuPar("uin_alert_lockon", ::func_sound, "uin_alert_lockon");
	//Utility
	self addMenuPar("uin_pulse_text_type", ::func_sound, "uin_pulse_text_type");
	self addMenuPar("uin_pulse_text_delete", ::func_sound, "uin_pulse_text_delete");
	self addMenuPar("uin_text_type_zork", ::func_sound, "uin_text_type_zork");
	//In Game
	self addMenuPar("uin_alert_slideout", ::func_sound, "uin_alert_slideout");
	self addMenuPar("uin_gamble", ::func_sound, "uin_gamble");
	
	//Traps
	//Electric
	self addmenu("main_sounds_common_traps", "Play Sound Menu", "main_sounds");
	self addHeadline("Electric");
	self addMenuPar("zmb_elec_start", ::func_sound, "zmb_elec_start");
	self addMenuPar("zmb_elec_loop", ::func_sound, "zmb_elec_loop");
	self addMenuPar("zmb_elec_arc", ::func_sound, "zmb_elec_arc");
	self addMenuPar("zmb_elec_jib_zombie", ::func_sound, "zmb_elec_jib_zombie");
	self addMenuPar("zmb_elec_current_loop", ::func_sound, "zmb_elec_current_loop");
	self addMenuPar("zmb_exp_jib_zombie", ::func_sound, "zmb_exp_jib_zombie");
	self addMenuPar("zmb_sizzle", ::func_sound, "zmb_sizzle");
	self addMenuPar("zmb_zombie_arc", ::func_sound, "zmb_zombie_arc");
	self addMenuPar("zmb_ignite", ::func_sound, "zmb_ignite");
	//Fire
	self addHeadline("Fire");
	self addMenuPar("zmb_firetrap_start", ::func_sound, "zmb_firetrap_start");
	self addMenuPar("zmb_firetrap_loop", ::func_sound, "zmb_firetrap_loop");
	self addMenuPar("zmb_firetrap_end", ::func_sound, "zmb_firetrap_end");
	self addMenuPar("zmb_onfire", ::func_sound, "zmb_onfire");
	
	//Weapons
	//Monkeybomb
	//SFX
	self addmenu("main_sounds_common_weapons", "Play Sound Menu", "main_sounds");
	self addHeadline("Monkeybomb");
	self addMenuPar("zmb_monkeybomb_cym", ::func_sound, "zmb_monkeybomb_cym");
	self addMenuPar("zmb_monkey_song", ::func_sound, "zmb_monkey_song");
	self addMenuPar("zmb_monkey_throw", ::func_sound, "zmb_monkey_throw");
	//Anim
	self addMenuPar("zmb_monkey_anim_cymb", ::func_sound, "zmb_monkey_anim_cymb");
	self addMenuPar("zmb_monkey_anim_key", ::func_sound, "zmb_monkey_anim_key");
	//Bowie Knife
	//Buy Flourish
	self addHeadline("Bowie Knife");
	self addMenuPar("zmb_bowie_flourish_start", ::func_sound, "zmb_bowie_flourish_start");
	self addMenuPar("zmb_bowie_flourish_turn", ::func_sound, "zmb_bowie_flourish_turn");
	self addMenuPar("zmb_bowie_flourish_toss", ::func_sound, "zmb_bowie_flourish_toss");
	self addMenuPar("zmb_bowie_flourish_catch", ::func_sound, "zmb_bowie_flourish_catch");
	//Use
	self addMenuPar("zmb_bowie_swing", ::func_sound, "zmb_bowie_swing");
	self addMenuPar("zmb_bowie_stab", ::func_sound, "zmb_bowie_stab");
	self addMenuPar("zmb_bowie_pull", ::func_sound, "zmb_bowie_pull");
	//Autoturret
	self addHeadline("Autoturret");
	self addMenuPar("zmb_turret_startup", ::func_sound, "zmb_turret_startup");
	self addMenuPar("zmb_turret_down", ::func_sound, "zmb_turret_down");
	

	
	
	self addmenu("main_teleport", "Teleport Menu", "main");
	self addMenuPar("Save Position", ::func_togglePostionSystem_save);
	self addMenuPar("Modify Position", ::controlMenu, "newMenu", "main_teleport_modify");
	self addMenuPar("Load saved Postion", ::func_togglePostionSystem_load);
	self addMenuPar("Teleport All Zombies to saved Postion", ::func_togglePostionSystem_load_zombz);
	self addMenuPar("Create Spawn Point for Zombies.", ::func_togglePostionSystem_load_zombz_spawn);
	self addMenuPar("Create Spawn Trapper for Zombies.", ::func_togglePostionSystem_load_zombz_loop);
	self addMenuPar("Teleport to Sky", ::func_tel_sky);
	self addMenuPar("Teleport to Ground", ::func_tel_ground);
	self addMenuPar("Teleport to Crosshair Position", ::func_tel_trace);
	self addMenuPar("Teleport to nearest Zombie", ::func_tel_near_zombz);
	
	
	self addmenu("main_teleport_modify", "Modify Position", "main_teleport");
	self addMenuPar("^2+100 X", ::func_togglePostionSystem_modify_pos,(100,0,0));
	self addMenuPar("^2+50 X", ::func_togglePostionSystem_modify_pos,(50,0,0));
	self addMenuPar("^2+10 X", ::func_togglePostionSystem_modify_pos,(10,0,0));
	self addMenuPar("^1-10 X", ::func_togglePostionSystem_modify_pos,(-10,0,0));
	self addMenuPar("^1-50 X", ::func_togglePostionSystem_modify_pos,(-50,0,0));
	self addMenuPar("^1-100 X", ::func_togglePostionSystem_modify_pos,(-100,0,0));
	
	self addMenuPar("^2+100 Y", ::func_togglePostionSystem_modify_pos,(0,100,0));
	self addMenuPar("^2+50 Y", ::func_togglePostionSystem_modify_pos,(0,50,0));
	self addMenuPar("^2+10 Y", ::func_togglePostionSystem_modify_pos,(0,10,0));
	self addMenuPar("^1-10 Y", ::func_togglePostionSystem_modify_pos,(0,-10,0));
	self addMenuPar("^1-50 Y", ::func_togglePostionSystem_modify_pos,(0,-50,0));
	self addMenuPar("^1-100 Y", ::func_togglePostionSystem_modify_pos,(0,-100,0));
	
	self addMenuPar("^2+100 Z", ::func_togglePostionSystem_modify_pos,(0,0,100));
	self addMenuPar("^2+50 Z", ::func_togglePostionSystem_modify_pos,(0,0,50));
	self addMenuPar("^2+10 Z", ::func_togglePostionSystem_modify_pos,(0,0,10));
	self addMenuPar("^1-10 Z", ::func_togglePostionSystem_modify_pos,(0,0,-10));
	self addMenuPar("^1-50 Z", ::func_togglePostionSystem_modify_pos,(0,0,-50));
	self addMenuPar("^1-100 Z", ::func_togglePostionSystem_modify_pos,(0,0,-100));
	
	
	 

	self addmenu("main_customize", "Customize Menu", "main");
	self addMenuPar("Theme Switcher", ::controlMenu,"newMenu","main_customize_themes");
	self addMenuPar("Theme Color", ::controlMenu,"newMenu","main_customize_theme_color");
	self addMenuPar("Theme X Position", ::controlMenu,"newMenu","main_customize_x");
	
	self addHeadline("Title Text Settings");
	self addMenuPar("Title Text Color", ::controlMenu,"newMenu","main_customize_title_color");
	self addMenuPar("Title Text Font Type", ::controlMenu,"newMenu","main_customize_background_font_title");
	
	self addHeadline("Menu Text Settings");
	self addMenuPar("Menu Text Color", ::controlMenu,"newMenu","main_customize_text_color");
	self addMenuPar("Menu Text Font Type", ::controlMenu,"newMenu","main_customize_background_font_menu");
	
	
	self addHeadline("Background Settings");
	self addMenuPar("Background Color", ::controlMenu,"newMenu","main_customize_background_color");
	self addMenuPar("Background Shader", ::controlMenu,"newMenu","main_customize_background_shader");
	self addMenuPar("Background Alpha", ::controlMenu,"newMenu","main_customize_background_alpha");
	
	self addHeadline("Scroller Settings");
	self addMenuPar("Scroller Color", ::controlMenu,"newMenu","main_customize_scroller_color");
	self addMenuPar("Scroller Shader", ::controlMenu,"newMenu","main_customize_background_scroller");
	self addMenuPar("Scroller Alpha", ::controlMenu,"newMenu","main_customize_scroller_alpha");
	
	self addHeadline("BarTop Settings");
	self addMenuPar("BarTop Color", ::controlMenu,"newMenu","main_customize_barTop_color");
	self addMenuPar("BarTop Shader", ::controlMenu,"newMenu","main_customize_background_bartop");
	self addMenuPar("BarTop Alpha", ::controlMenu,"newMenu","main_customize_barTop_alpha");
	
	self addHeadline("Misc Settings");
	self addMenuPar("Toggle Open Animation", ::setTogglerFunction,"animations");
	self addMenuPar("Toggle Menu Sound Effects", ::setTogglerFunction,"sound_in_menu");
	self addMenuPar("Toggle Developer Println", ::setTogglerFunction,"developer_print");
	
	
	self CreateArrayItemMenu("main_customize_background_shader","main_customize","Background Shader","",::setMenuBackground,level.shader);
	self CreateArrayItemMenu("main_customize_background_scroller","main_customize","Scroller Shader","",::setMenuScroller,level.shader);
	self CreateArrayItemMenu("main_customize_background_bartop","main_customize","BarTop Shader","",::setMenuBarTop,level.shader);
	
	self addmenu("main_customize_themes", "Theme Switcher", "main_customize");
	self addMenuPar("Default Theme", ::switchDesignTemplates,"default");
	self addMenuPar("Red-Curve Theme", ::switchDesignTemplates,"saved_1");
	self addMenuPar("Bow-Tie Theme", ::switchDesignTemplates,"saved_2");
	self addMenuPar("Baron Theme", ::switchDesignTemplates,"saved_3");
	self addMenuPar("Gr3Zz v3 Theme", ::switchDesignTemplates,"saved_4");
	self addMenuPar("Alert Theme", ::switchDesignTemplates,"saved_5");
	self addMenuPar("Random Theme", ::switchDesignTemplates,"random");
	self addMenuPar("Give Parameters for my current Theme", ::givePar_Theme);

	self addmenu("main_customize_background_font_title", "Title Text Font Type", "main_customize");
	self addMenuPar("Set Font to Objective", ::setMenuSetting,"font_title","objective");
	self addMenuPar("Set Font to Small", ::setMenuSetting,"font_title","small");
	self addMenuPar("Set Font to Hudbig", ::setMenuSetting,"font_title","hudbig");
	self addMenuPar("Set Font to Fixed", ::setMenuSetting,"font_title","fixed");
	self addMenuPar("Set Font to Smallfixed", ::setMenuSetting,"font_title","smallfixed");
	self addMenuPar("Set Font to Bigfixed", ::setMenuSetting,"font_title","bigfixed");
	self addMenuPar("Set Font to Default", ::setMenuSetting,"font_title","default");

	self addmenu("main_customize_background_font_menu", "Menu Text Font Type", "main_customize");
	self addMenuPar("Set Font to Objective", ::setMenuSetting,"font_options","objective");
	self addMenuPar("Set Font to Small", ::setMenuSetting,"font_options","small");
	self addMenuPar("Set Font to Hudbig", ::setMenuSetting,"font_options","hudbig");
	self addMenuPar("Set Font to Fixed", ::setMenuSetting,"font_options","fixed");
	self addMenuPar("Set Font to Smallfixed", ::setMenuSetting,"font_options","smallfixed");
	self addMenuPar("Set Font to Bigfixed", ::setMenuSetting,"font_options","bigfixed");
	self addMenuPar("Set Font to Default", ::setMenuSetting,"font_options","default");
	
	
	self addmenu("main_customize_background_alpha", "Background Alpha", "main_customize");
	updateMenu_nuumber_float_system_Map(::setMenuSetting, "alpha_background");
	
	self addmenu("main_customize_scroller_alpha", "Scroller Alpha", "main_customize");
	updateMenu_nuumber_float_system_Map(::setMenuSetting, "alpha_scroller");
	
	self addmenu("main_customize_barTop_alpha", "BarTop Alpha", "main_customize");
	updateMenu_nuumber_float_system_Map(::setMenuSetting, "alpha_barTop");
	

	self addmenu("main_customize_theme_color", "Color Theme Menu", "main_customize");
	updateMenu_color_system_Map(::setMenuSetting_ThemeColor);
	
	self addmenu("main_customize_title_color", "Title Text Color", "main_customize");
	updateMenu_color_system_Map(::setMenuSetting_TopTextColor);
	
	self addmenu("main_customize_background_color", "Background Color", "main_customize");
	updateMenu_color_system_Map(::setMenuSetting_BackgroundColor);
	
	self addmenu("main_customize_scroller_color", "Scroller Color", "main_customize");
	updateMenu_color_system_Map(::setMenuSetting_color_scroller);
	
	self addmenu("main_customize_barTop_color", "BarTop Color", "main_customize");
	updateMenu_color_system_Map(::setMenuSetting_color_barTop);
	
	self addmenu("main_customize_text_color", "Menu Text Color", "main_customize");
	updateMenu_color_system_Map(::setMenuSetting_TextColor);
	
	
	self addmenu("main_customize_x", "Postion X of Menu", "main_customize");
	self addMenuPar("X to ^2+100 ^7Position", ::setMenuSetting, "pos_x",100);
	self addMenuPar("X to ^2+10 ^7Position", ::setMenuSetting, "pos_x",10);
	self addMenuPar("X to ^2+1 ^7Position", ::setMenuSetting, "pos_x",1);
	self addMenuPar("X to ^1-1 ^7Position", ::setMenuSetting, "pos_x", (0-1));
	self addMenuPar("X to ^1-10 ^7Position", ::setMenuSetting, "pos_x", (0-10));
	self addMenuPar("X to ^1-100 ^7Position", ::setMenuSetting, "pos_x", (0-100));
	
	
	self addmenu("main_lobby", "Lobby Menu", "main");
	self addMenuPar("Toggle Super Speed", ::quick_modificator,"g_speed",500,999,190);
	self addMenuPar("Super Speed Bar", ::EditorDvarCabCon, 1000,1,"g_speed",10,190);
	self addMenuPar("Toggle Super Jump", ::quick_modificator,"jump_height",500,1000,39);
	self addMenuPar("Super Jump Bar", ::EditorDvarCabCon, 1000,1,"jump_height",10,39);
	self addMenuPar("Toggle Super Gravity", ::quick_modificator, "bg_gravity", 400,100,800);
	self addMenuPar("Super Gravity Bar", ::EditorDvarCabCon, 1200,1,"bg_gravity",10,800);
	self addMenuPar("Toggle Super Physical Gravity", ::quick_modificator, "phys_gravity", 50,0,-800);
	self addMenuPar("Super Physical Gravity Bar", ::EditorDvarCabCon, 1000,-1000,"phys_gravity",10,-800);
	self addMenuPar("Toggle Timescale", ::quick_modificator, "timescale", 2,.5,1);
	self addMenuPar("Timescale Bar", ::EditorDvarCabCon, 10,.1,"timescale",.1,1);
	self addMenuPar("End Game", ::func_endgame);
    self addMenuPar("Restart Game", ::func_restartgame);
	//self addMenuPar("Quick Leave Game", ::quick_modificator, "disconnect", "","");
    self addMenuPar("Spawn Ai Menu", ::controlMenu, "newMenu", "main_lobby_spawn_ai");
	self addMenuPar("Toggle Disable Ai Spawners", ::quick_modificator, "ai_disableSpawn", 1, 0);
    self addMenuPar("Toggle Friendlyfire", ::quick_modificator, "scr_friendlyfire", 1, 0);
    self addMenuPar("Toggle Entity Collision", ::quick_modificator, "phys_entityCollision", 0, 1);
    self addMenuPar("Toggle Disable every trap", ::func_trapdisable);
    self addMenuPar("Toggle Trap Actvity Time", ::func_TrapTimeTrap);
    self addMenuPar("Toggle Trap Cololdwon Time", ::func_colldownToggleTrap);
    self addMenuPar("Send Earthquake", ::func_earthquake);
    
	self addmenu("main_lobby_spawn_ai", "Spawn Ai", "main_lobby");
	self addMenuPar("Spawn 1 Zombie Ai", ::func_spawn_zombie, 1);
	self addMenuPar("Spawn 2 Zombie Ai", ::func_spawn_zombie, 2);
	self addMenuPar("Spawn 3 Zombie Ai", ::func_spawn_zombie, 3);
	self addMenuPar("Spawn 4 Zombie Ai", ::func_spawn_zombie, 4);
	self addMenuPar("Spawn 5 Zombie Ai", ::func_spawn_zombie, 5);
	self addMenuPar("Spawn 10 Zombie Ai", ::func_spawn_zombie, 10);
	self addMenuPar("Spawn 15 Zombie Ai", ::func_spawn_zombie, 15);
    
	//EditorDvarCabCon, max,min,dvar,value_add,value_default
	
	self addmenu("main_host", "Host Menu", "main");
	self addMenuPar("Toggle Show List", ::quick_modificator, "ui_showList", 1, 0);
	self addMenuPar("Toggle Display FbColorTable", ::quick_modificator, "r_showFbColorDebug", 1, 0);
    self addMenuPar("Toggle Display DoF Informations", ::quick_modificator, "r_dof_showdebug", 1, 0);
    self addMenuPar("Toggle Display Sky Informations", ::quick_modificator, "r_sky_intensity_showDebugDisplay", 1, 0);
	self addMenuPar("Toggle Cursor Hints", ::quick_modificator, "cg_cursorHints", 0, 4);
    self addMenuPar("Cursor Hints Types", ::quick_modificator, "cg_cursorHints", 1, 2, 4);
    
	self addmenu("main_fun", "Fun Menu", "main");
	self addMenuPar("Clone",::func_clonemodel, 1);
    self addMenuPar("Death Clone",::func_clonemodel, 2);
    self addMenuPar("Exploded Clone",::func_clonemodel, 3);
	self addMenuPar("Toggle Sprint CameraBob", ::quick_modificator, "player_sprintCameraBob", 2,0, 0.5);
	self addMenuPar("Toggle Modded Tracer", ::func_moddedtracer);
	self addMenuPar("Toggle Auto Tbag", ::func_autotbag);
	self addMenuPar("Toggle 3rd Person", ::quick_modificator, "cg_thirdperson",1,0);
	self addMenuPar("Toggle Invisible", ::func_invisible);
	self addMenuPar("Toggle Flashing Player", ::func_flashingPlayer);
	self addMenuPar("Toggle Jet Pack", ::func_doJetPack);
	self addMenuPar("Toggle Ice Skater", ::func_IceSkater);
	self addMenuPar("Build Windows", maps\_zombiemode_powerups::start_carpenter_new, self.origin);
	self addMenuPar("Drop Physical Skull", ::func_alwaysphysical, "zombie_skull");
	self addMenuPar("Drop Physical Vending", ::func_alwaysphysical, "zombie_vending_jugg");
	self addMenuPar("Physical Explosion", ::func_Physical_exlo);
	self addMenuPar("Physical Cylinder", ::func_Physical_Cylinder);
	self addMenuPar("Physical Drop", ::func_Physical_drop_of_all);
	self addMenuPar("Walking Zombies", ::ThreadAtAllZombz, ::setMovmentSpeed, "walk");
	self addMenuPar("Running Zombies", ::ThreadAtAllZombz, ::setMovmentSpeed, "run");
	self addMenuPar("Sprinting Zombies", ::ThreadAtAllZombz, ::setMovmentSpeed, "sprint");
	self addMenuPar("Headless Zombies", ::ThreadAtAllZombz, ::func_detachAll);
	self addMenuPar("Dancing Zombies", ::ThreadAtAllZombz, ::func_dancingZombz);
	self addMenuPar("Spawn Zombie Boss", ::func_spawnAZombieBoss);
	self addMenuPar("Defaultactor Zombies", ::ThreadAtAllZombz, ::func_setModel, "defaultactor");
	
	
	self addmenu("main_effects", "Graphics Effects Menu", "main");
	self addMenuPar("Toggle Disable FXs", ::quick_modificator, "fx_enable", 0, 1);
    self addMenuPar("Toggle Fog Effect", ::quick_modificator, "r_fog", 0, 1);
    self addMenuPar("Toggle Blur Effect", ::quick_modificator, "r_blur", 5, 0);
    self addMenuPar("Toggle Water Sheeting Effect", ::quick_modificator, "r_waterSheetingFX_enable", 1, 0);
    self addMenuPar("Toggle Fullbright Effect", ::quick_modificator, "r_fullbright", 1, 0);
    self addMenuPar("Toggle Color Map", ::quick_modificator, "r_colorMap", 2, 0, 1);
    self addMenuPar("Toggle Shader Effect", ::quick_modificator, "r_debugShader", 1, 3, 0);
	self addMenuPar("Toggle Render Distance", ::quick_modificator, "r_zfar", 1, 500,0);
	self addMenuPar("Toggle Render Distance Bar", ::EditorDvarCabCon, 10000,0,"r_zfar",1,0);
    self addMenuPar("Toggle Blood", ::quick_modificator, "cg_blood", 0, 1);
	self addMenuPar("Toggle Enable Water", ::quick_modificator, "r_drawWater", 0, 1);
    self addMenuPar("Toggle Enable Shadows", ::quick_modificator, "sm_enable", 1, 0);
    self addMenuPar("Toggle Enable Self Shadow", ::quick_modificator, "r_enablePlayerShadow", 1, 0);
	self addMenuPar("Toggle DoF", ::quick_modificator, "r_dof_enable", 0, 1);
    self addMenuPar("Toggle DoF Bias", ::quick_modificator, "r_dof_bias", 0, 3, 0.5);
    self addMenuPar("Toggle Override DoF", ::quick_modificator, "r_dof_tweak", 1, 0);
	self addMenuPar("Toggle Crosshair", ::quick_modificator, "cg_drawCrosshair", 0, 1);
    self addMenuPar("Toggle Crosshair Enemy Effect", ::quick_modificator, "cg_crosshairEnemyColor", 0, 1);
    self addMenuPar("Toggle Herolightling", ::quick_modificator, "r_heroLighting", 0, 1);
    self addMenuPar("Toggle Herolight Saturation", ::quick_modificator, "r_heroLightSaturation", 0, 1);
    self addMenuPar("Toggle Orange Herolight", ::quick_modificator, "r_heroLightColorTemp", 1650, 6500);
    self addMenuPar("Toggle Black Herolight", ::quick_modificator, "r_heroLightScale", "0 0 0", "2 2 2", "1 1 1");
    self addMenuPar("Toggle Flat Model Effect", ::quick_modificator, "r_normalMap", 1, 0);
    self addMenuPar("Toggle Disable Impact Effect", ::quick_modificator, "phys_impact_fx", 0, 1);
    self addMenuPar("Toggle Bloom Tweaks Effect", ::quick_modificator, "r_bloomTweaks", 1, 0);
    self addMenuPar("Toggle Bloom Tweaks Effect Scale", ::quick_modificator, "r_bloomColorScale", "4 4 4", "8 8 8","0 0 0");
    

	self addmenu("main_w2", "Select Infection Mode", "main_w2");
	self addMenuPar("Normal Menu Mode", ::_gamemodeselect,"gamemode_menu_main");
	self addMenuPar("Sharpshooter", ::_gamemodeselect,"gamemode_sharpshooter");
	self addMenuPar("Normal Surive Mode", ::_gamemodeselect,"gamemode_normal");
	
	self addmenu("main_bullets", "Bullets Menu", "main");
	self addMenuPar("Modded Bullets ^1OFF", ::func_gunbullets, "_stop");
	self addMenuPar("Weapons Bullets Types", ::controlMenu, "newMenu", "main_bullets_weapons");
	self addMenuPar("Fx Bullets Types", ::controlMenu, "newMenu", "main_bullets_fx");
	
	
	//DEV: VALUE_BAR at all here
	self addmenu("main_scoreboard", "Scoreboard Modifications", "main");
    self addMenuPar("Scoreboard Color", ::controlMenu, "newMenu", "main_colorscore");
	self addMenuPar("Scoreboard Font",::quick_modificator, "cg_scoreboardFont", 6, 5, 3);
	self addMenuPar("Scoreboard Font Bar",::EditorDvarCabCon, 6,0,"cg_scoreboardFont",1,3);
	self addMenuPar("Scoreboard Ping Graph",::quick_modificator, "cg_scoreboardPingGraph", 1, 0);
	self addMenuPar("Scoreboard Width",::quick_modificator, "cg_scoreboardWidth", 1000, 300, 500);
	self addMenuPar("Scoreboard Width Bar",::EditorDvarCabCon, 1500,100,"cg_scoreboardWidth",10,500);
	self addMenuPar("Scoreboard Height",::quick_modificator, "cg_scoreboardHeight", 200, 400, 330);
	self addMenuPar("Scoreboard Height Bar",::EditorDvarCabCon, 1500,100,"cg_scoreboardHeight",10,330);
    self addMenuPar("Scoreboard Banner Height",::quick_modificator, "cg_scoreboardBannerHeight", 0, 100, 35);
	
	
	self addmenu("main_colorscore", "Scoreboard Color", "main_scoreboard");
	self addMenuPar("Red",::setScoreBoardColor, "1 0 0 1");
	self addMenuPar("Blue",::setScoreBoardColor, "0 0 1 1");
	self addMenuPar("Green",::setScoreBoardColor, "0 1 0 1");
	self addMenuPar("White",::setScoreBoardColor, "1 1 1 1");
	self addMenuPar("Black",::setScoreBoardColor, "0 0 0 1");
	self addMenuPar("Yellow",::setScoreBoardColor, "1 1 0 0");
	self addMenuPar("Cyan",::setScoreBoardColor, "0 1 1 1");
	self addMenuPar("Flashing",::setScoreBoardColor, "flash");

	
	/*
    cg_scoreboardBannerHeight "35" - set the high of the scoreboard
	cg_scoreboardFont "3" - set the font 0 - 6
	cg_scoreboardHeight "330" - height of scoreboard
	cg_scoreboardPingGraph "0" - showping graph 
	cg_scoreboardWidth "500" - width of scoreboard /max 1000 /min 300
	*/
	
	
	
	self addmenu("main_round", "Round Menu", "main");
    self addMenuPar("Set to Round 1337",::func_roundsystem, 1337, true);
    self addMenuPar("+ 1337 Rounds",::func_roundsystem, 1337, false);
    self addMenuPar("- 1337 Rounds",::func_roundsystem, -1337, false);
    self addMenuPar("Set to Round 100",::func_roundsystem, 100, true);
    self addMenuPar("+ 100 Rounds",::func_roundsystem, 100, false);
    self addMenuPar("- 100 Rounds",::func_roundsystem, -100, false);
    self addMenuPar("Set to Round 75",::func_roundsystem, 75, true);
    self addMenuPar("+ 75 Rounds",::func_roundsystem, 75, false);
    self addMenuPar("- 75 Rounds",::func_roundsystem, -75, false);
    self addMenuPar("Set to Round 50",::func_roundsystem, 50, true);
    self addMenuPar("+ 50 Rounds",::func_roundsystem, 50, false);
    self addMenuPar("- 50 Rounds",::func_roundsystem, -50, false);
    self addMenuPar("Set to Round 25",::func_roundsystem, 25, true);
    self addMenuPar("+ 25 Rounds",::func_roundsystem, 25, false);
    self addMenuPar("- 25 Rounds",::func_roundsystem, -25, false);
    self addMenuPar("+ 1 Rounds",::func_roundsystem, 1, false);
    self addMenuPar("- 1 Rounds",::func_roundsystem, -1, false);
    self addMenuPar("Set to Round 1",::func_roundsystem, 1, true);
    
    
	self addmenu("main_weapons_mods", "Weapons Mods Menu", "main");
	if(level.has_pack_a_punch == true)
		self addMenuPar("Packer Punch Options",::controlMenu, "newMenu", "main_weapons_mods_pp");
    else
		self addMenuPar("Packer Punch Options (^1WARNING!^7)",::controlMenu, "newMenu", "main_weapons_mods_pp");//DEV INFO maybe we should remove ?
	self addMenuPar("Flashlight Menu",::controlMenu, "newMenu", "main_weapons_mods_flashlight");
	self addMenuPar("Viewmodel/Weapon Postion",::controlMenu, "newMenu", "main_weapons_mods_viewmodel_pos");
	self addMenuPar("Take Current Weapon",::func_takeWeapon);
	//self addMenuPar("Drop Current Weapon",::func_dropWeapon);
	
	self addmenu("main_weapons_mods_viewmodel_pos", "Viewmodel/Weapon Postion", "main_weapons_mods");
    self addMenuPar("Field of View",::controlMenu, "newMenu", "main_weapons_mods_viewmodel_pos_fov");
	self addMenuPar("X Position",::controlMenu, "newMenu", "main_weapons_mods_viewmodel_pos_x");
	self addMenuPar("Y Position",::controlMenu, "newMenu", "main_weapons_mods_viewmodel_pos_y");
	self addMenuPar("Z Position",::controlMenu, "newMenu", "main_weapons_mods_viewmodel_pos_z");
	self addMenuPar("Default All Viewmodel/Weapon Postions",::def_call_main_weapons_mods_viewmodel_pos);
	
	self addmenu("main_weapons_mods_viewmodel_pos_fov", "Field of View", "main_weapons_mods_viewmodel_pos");
    self addMenuPar("Set ^2Field Of View^7 To ^2160",::setDvarFunction_, "cg_fov", 160);
    self addMenuPar("Set ^2Field Of View^7 To ^2150",::setDvarFunction_, "cg_fov", 150);
    self addMenuPar("Set ^2Field Of View^7 To ^2140",::setDvarFunction_, "cg_fov", 140);
    self addMenuPar("Set ^2Field Of View^7 To ^2130",::setDvarFunction_, "cg_fov", 130);
    self addMenuPar("Set ^2Field Of View^7 To ^2120",::setDvarFunction_, "cg_fov", 120);
    self addMenuPar("Set ^2Field Of View^7 To ^2110",::setDvarFunction_, "cg_fov", 110);
    self addMenuPar("Set ^2Field Of View^7 To ^2100",::setDvarFunction_, "cg_fov", 100);
    self addMenuPar("Set ^2Field Of View^7 To ^290",::setDvarFunction_, "cg_fov", 90);
    self addMenuPar("Set ^2Field Of View^7 To ^280",::setDvarFunction_, "cg_fov", 80);
    self addMenuPar("Set ^2Field Of View^7 To ^270",::setDvarFunction_, "cg_fov", 70);
    self addMenuPar("Set ^2Field Of View^7 To 65",::setDvarFunction_, "cg_fov", 65);
    self addMenuPar("Set ^2Field Of View^7 To ^160",::setDvarFunction_, "cg_fov", 60);
    self addMenuPar("Set ^2Field Of View^7 To ^150",::setDvarFunction_, "cg_fov", 50);
    self addMenuPar("Set ^2Field Of View^7 To ^140",::setDvarFunction_, "cg_fov", 40);
    self addMenuPar("Set ^2Field Of View^7 To ^130",::setDvarFunction_, "cg_fov", 30);
    self addMenuPar("Set ^2Field Of View^7 To ^120",::setDvarFunction_, "cg_fov", 20);
    self addMenuPar("Set ^2Field Of View^7 To ^110",::setDvarFunction_, "cg_fov", 10);
    self addMenuPar("Set ^2Field Of View^7 To ^10",::setDvarFunction_, "cg_fov", 0);
	self addMenuPar("^2Field Of View^7 Bar", ::EditorDvarCabCon, 160,1,"cg_fov",1,65);
    

	
    self addmenu("main_weapons_mods_viewmodel_pos_x", "X Position", "main_weapons_mods_viewmodel_pos");
    updateMenu_nuumber_int_system_Map(::setDvarFunction_mod_cg_gun, "x");
	
    self addmenu("main_weapons_mods_viewmodel_pos_y", "Y Position", "main_weapons_mods_viewmodel_pos");
    updateMenu_nuumber_int_system_Map(::setDvarFunction_mod_cg_gun, "y");
	
    self addmenu("main_weapons_mods_viewmodel_pos_z", "Z Position", "main_weapons_mods_viewmodel_pos");
    updateMenu_nuumber_int_system_Map(::setDvarFunction_mod_cg_gun, "z");
    
	
	self addmenu("main_weapons_mods_flashlight", "Flashlight Menu", "main_weapons_mods");
    self addMenuPar("Enable Flashlight",::quick_modificator, "r_enableFlashlight", 1, 0);
    self addMenuPar("Flashlight Color",::controlMenu, "newMenu", "main_weapons_mods_flashlight_color");
    self addMenuPar("Flashlight Brightness",::quick_modificator, "r_flashLightBrightness", 15, 25, 10);
    self addMenuPar("Flashlight Brightness Bar",::EditorDvarCabCon, 25,1,"r_flashLightBrightness",0.5,10); // EditorDvarCabCon, max,min,dvar,value_add,value_default
    self addMenuPar("Flashlight End Radius",::quick_modificator, "r_flashLightEndRadius", 100, 600, 300);
    self addMenuPar("Flashlight End Radius Bar",::EditorDvarCabCon, 1200,1,"r_flashLightEndRadius",10,300);
    self addMenuPar("Flashlight Flicker",::quick_modificator, "r_flashLightFlickerAmount", 1, 0);
    self addMenuPar("Flashlight Flicker Rate",::quick_modificator, "r_flashLightFlickerRate", 10, 30, 65);
    self addMenuPar("Flashlight Flicker Rate Bar",::EditorDvarCabCon, 65,1,"r_flashLightFlickerRate",0.5,65);
    self addMenuPar("Flashlight Shadow",::quick_modificator, "r_flashLightShadows", 1, 0);


	/*
    #r_enableFlashlight 0/1 enable a flashlight
	#	--> r_flashLightColor 1 1 1/ r g b color 
	#	--> r_flashLightBrightness 10/25 brightness scale for flash light
	#	--> r_flashLightEndRadius 300/1200 radius of flash light
	#	--> r_flashLightFlickerAmount 0/1 Flash the flash light
	#	--> r_flashLightFlickerRate 65/0.1 Rate per secounds
	#	--> r_flashLightShadows 1/0
	*/
	self addmenu("main_weapons_mods_flashlight_color", "Set Color of the Flashlight", "main_weapons_mods_flashlight");
	self updateMenu_color_system_Map(::_flashlightcolor);
	
	self addmenu("main_weapons_mods_pp", "Packer Punch Options", "main_weapons_mods");
    self addMenuPar("Upgrade Current Weapon",::weaponPackerPunchCurrentWeapon);
    self addMenuPar("Unupgrade Current Weapon",::weaponDePackerPunchCurrentWeapon);
    
	
	
	self addmenu("main_dev", "^FDEVELOPER", "main");
    self addMenuPar("Shader Module",::controlMenu, "newMenu", "main_dev_shader");
    self addMenuPar("Dump effects Modul",::getDumpOfItem, level._effect, false);
    //self addMenuPar("Dump effects Modul GetDynModels",::getDumpOfItem, ::GetDynModels, true);
   // self addMenuPar("Dump effects Modul GetMiscModels",::getDumpOfItem, ::GetMiscModels, true);
    self addMenuPar("Dump models Modul",::S,"^1removed");
    self addMenuPar("testNormalWeapon",::testNormalWeapon);
    self addMenuPar("testNormalWeapon_string",::testNormalWeapon_string);
    self addMenuPar("test_call",::test_call);
    self addMenuPar("getMap",::S,get_map());
    self addMenuPar("func_test",::func_test12);
    self addMenuPar("getOption Size LASTCOUNT: 07.02",::S,self.menu_count);
    self addMenuPar("Dvar Slider Field Of View",::dvar_test_developeemtn);




    self addmenu("main_mods", "Main Modifications", "main");
    self addMenuPar("Toggle Godmode",::Toggle_God);
    self addMenuPar("Toggle Demi Godmode",::Toggle_Demi_God);
	self addMenuPar("Toggle Freeze Ammunition", ::quick_modificator,"player_sustainAmmo",1,0);
	self addMenuPar("Toggle Unlimited Ammunition", ::func_newUnlimitedAmmo);
	self addMenuPar("Refill Ammo", ::func_ammo_refill);
    self addMenuPar("Toggle Quick Field Of View", ::quick_modificator, "cg_fov",90,120,65);
    self addMenuPar("Field Of View Bar", ::EditorDvarCabCon, 160,1,"cg_fov",1,65);
    self addMenuPar("Score Menu", ::controlMenu, "newMenu", "main_mods_score");
    self addMenuPar("Toggle Ufo Mode", ::caller_ufomode);
    self addMenuPar("Toggle Spectator Mode", ::Toggle_Spectator);
    self addMenuPar("Toggle Rotate Player Angles", ::rotateAngles);
	self addMenuPar("Toggle No Target", ::func_noTarget);
	self addMenuPar("Toggle Aquatic Screen", ::quick_modificator, "r_waterSheetingFX_enable", 1, 0);
	self addMenuPar("Toggle Healthshield", ::func_healthShield);
    self addMenuPar("Toggle Left Side Weapon", ::quick_modificator,"cg_gun_y",10,0);
    self addMenuPar("Toggle 3rd Person", ::quick_modificator, "cg_thirdperson",1,2,0);
    self addMenuPar("Toggle 3rd Person Range", ::quick_modificator, "cg_thirdpersonrange",300,1000,120);
    self addMenuPar("3rd Person Range Bar", ::EditorDvarCabCon, 1000,0,"cg_thirdpersonrange",10,120);
	self addMenuPar("Fast Zombie Count", ::print_get_current_zombz_count);
	self addMenuPar("Fast Corpse Count", ::print_get_current_corpse_count);
	self addMenuPar("Show Position", ::print_get_pos);
	self addMenuPar("Bruh!", ::func_sound, "evt_belch");
	if(isDefined(level._effect["thundergun_smoke_cloud"]))self addMenuPar("Toggle Dead Ghost Smoke", ::Toogler_FX_System, "thundergun_smoke_cloud");
	if(isDefined(level._effect["def_explosion"]))self addMenuPar("Toggle Explosion Man ", ::Toogler_FX_System, "def_explosion");
	if(isDefined(level._effect["rise_burst_water"]))self addMenuPar("Toggle Killing Water", ::Toogler_FX_System, "rise_burst_water");
	if(isDefined(level._effect["lightning_dog_spawn"]))self addMenuPar("Toggle Lightning Strike", ::Toogler_FX_System, "lightning_dog_spawn");
	if(isDefined(level._effect["fx_zombie_mainframe_beam"]))self addMenuPar("Toggle Light Strike", ::Toogler_FX_System, "fx_zombie_mainframe_beam");
	if(isDefined(level._effect["poltergeist"]))self addMenuPar("Toggle Poltergeist", ::Toogler_FX_System, "poltergeist");
	if(isDefined(level._effect["dog_gib"]))self addMenuPar("Toggle Bomb Killer", ::Toogler_FX_System, "dog_gib");
	
	
    
	
    //
	// new functions
	// 
    
	/*
	Dvars
	bg_weaponBobAmplitudeBase "0.16" - schwingen der waffe beim laufen 0.16 def 0 aus 1 extrem
	
	
	PERKS:
	
	--perk_weapRateMultiplier "0.75" - Change the speed to shot again! --> repaid fire
	--perk_weapReloadMultiplier "0.5"^- Change the reload speed! --> R+ repaid fire

	
	GENERELL:
	

	r_enableFlashlight 0/1 enable a flashlight
		--> r_flashLightColor 1 1 1/ r g b color 
		--> r_flashLightBrightness 10/25 brightness scale for flash light
		--> r_flashLightEndRadius 300/1200 radius of flash light
		--> r_flashLightFlickerAmount 0/1 Flash the flash light
		--> r_flashLightFlickerRate 65/0.1 Rate per secounds
		--> r_flashLightShadows 1/0
	 0/1
	 0/1 rendering without lights
	r_lightTweakSunLight 13/32-0  strenght sunlight
	 0/1 flat normal map
	 0/1 shows a material with color flags
	 0/1 water sheeting effect
	
	
	 1/0 enable blood
	 1/0 enable the enemy color on crosshair
	 0/1
	 1/0 shadows map on off
	
	
	
	*/

	self addmenu("second", "second Menu", "main");

	self addmenu("main_mods_score", "Modify Score", "main_mods");
		self addMenuPar("+1000000", ::add_to_player_score, 1000000);
		self addMenuPar("+100000", ::add_to_player_score, 100000);
		self addMenuPar("+10000", ::add_to_player_score, 10000);
		self addMenuPar("+1000", ::add_to_player_score, 1000);
		self addMenuPar("+100", ::add_to_player_score, 100);
		self addMenuPar("+10", ::add_to_player_score, 10);
		self addMenuPar("+1", ::add_to_player_score, 1);
		self addMenuPar("Reset", ::func_resetscore);
		self addMenuPar("-1", ::add_to_player_score, (0-1));
		self addMenuPar("-10", ::add_to_player_score, (0-10));
		self addMenuPar("-100", ::add_to_player_score, (0-100));
		self addMenuPar("-1000", ::add_to_player_score, (0-1000));
		self addMenuPar("-10000", ::add_to_player_score, (0-10000));
		self addMenuPar("-100000", ::add_to_player_score, (0-100000));
		//self addMenuPar("-1000000", ::minus_to_player_score, (0-1000000));
	/*foreach(array_each_var in array(100000000,10000000,1000000,100000,10000,1000,100))
		self addMenuPar("main_mods_score","+"+array_each_var, ::add_to_player_score, array_each_var);
	foreach(array_each_var in array(100,1000,10000,100000,1000000,10000000,100000000))
		self addMenuPar("main_mods_score","-"+array_each_var, ::minus_to_player_score, array_each_var);*/
       
	//***********************//
	//			PERKS		 //
	//***********************//
	
		
	self addmenu("main_perks", "Give Perks Menu", "main");
	vending_triggers = GetEntArray( "zombie_vending", "targetname" );
	if (! vending_triggers.size < 1 )
	{
	//self addMenuPar("Give Perk Instant", ::controlMenu, "newMenu", "main_perks_set");
	self addMenuPar("Give Perks", ::controlMenu, "newMenu", "main_perks_set_true");
	//self addMenuPar("Give Perks via Trigger", ::controlMenu, "newMenu", "main_perks_trigger");
	self addMenuPar("Super Perks (Modify Perks)", ::controlMenu, "newMenu", "main_perks_modify");
	}
	else
		self addMenuPar("Map does not contain any perks", ::S, "^1Map does not contain any perks");
	self addmenu("main_perks_set", "Give Perk Instant", "main_perks");
	self addmenu("main_perks_set_true", "Give Perks", "main_perks");
	self addmenu("main_perks_trigger", "Give Perks via Trigger", "main_perks");
	
	self addmenu("main_perks_modify", "Super Perks (Modify Perks)", "main_perks");
	self addMenuPar("Repiad Fire Weapons", ::modify_perks, "specialty_rof", "perk_weapRateMultiplier",0.75);
	self addMenuPar("Repiad Fire Size Bar", ::EditorDvarCabCon, 1,0,"perk_weapRateMultiplier",.01,0.75);
	self addMenuPar("Fastest Reload", ::modify_perks, "specialty_fastreload", "perk_weapReloadMultiplier",0.5);

    
	
	/*
	Dvars
	
	
	PERKS:
	
	--perk_weapRateMultiplier "0.75" - Change the speed to shot again! --> repaid fire
	--perk_weapReloadMultiplier "0.5"^- Change the reload speed! --> R+ repaid fire

	
	GENERELL:
	
	ai_disableSpawn 0/1 - disable enable spawn from AI 
	r_heroLighting 1/0
	r_heroLightSaturation 1/0 black and white
	r_heroLightScale", "1 1 1" /0 0 0, - color hero = 0 0 0 insmae black mode
	r_heroLightColorTemp 6500/1650 color element
	r_fog_disable 0/1 disable fog
	r_fog 1/0
	r_dof_tweak 0/1 overrides field of death effect 
	r_bloomTweaks 0/1 enalbe bloom tweaks
		--> r_bloomColorScale 0 0 0 0/8 8 8 8
	r_blur 0/32 blur effect
	r_colorMap 1/ 0 2 3 2=white 3=gray 0=black
	r_debugShader 0/1 2 3 4  1=normal 2=basisTangent 3=basisBinormal 4= basisNormal
	r_dof_enable 1/0 death of field enable / disable
		--> r_dof_bias 0.5 / 3 size um die objekte
	r_dof_showdebug 0/1 shows a list with inforamtions about dof
	r_sky_intensity_showDebugDisplay 0/1 
	r_drawWater 1/0 Enable/disanle water
	r_enableFlashlight 0/1 enable a flashlight
		--> r_flashLightColor 1 1 1/ r g b color 
		--> r_flashLightBrightness 10/25 brightness scale for flash light
		--> r_flashLightEndRadius 300/1200 radius of flash light
		--> r_flashLightFlickerAmount 0/1 Flash the flash light
		--> r_flashLightFlickerRate 65/0.1 Rate per secounds
		--> r_flashLightShadows 1/0
	r_enablePlayerShadow 0/1
	r_fullbright 0/1 rendering without lights
	r_lightTweakSunLight 13/32-0  strenght sunlight
	r_normalMap 0/1 flat normal map
	r_showFbColorDebug 0/1 shows a material with color flags
	r_waterSheetingFX_enable 0/1 water sheeting effect
	
	
	cg_blood 1/0 enable blood
	cg_crosshairEnemyColor 1/0 enable the enemy color on crosshair
	scr_friendlyfire 0/1
	sm_enable 1/0 shadows map on off
	
	
	
	*/
    
    self multimenuperks("Give Juggernaut",::give_perk_mod, "specialty_armorvest");
	self multimenuperks("Give Quickrevive",::give_perk_mod, "specialty_quickrevive");
	self multimenuperks("Give Fastreload",::give_perk_mod, "specialty_fastreload");
	self multimenuperks("Give Doubletap",::give_perk_mod, "specialty_rof");
    if ( is_true( level.zombiemode_using_marathon_perk ) )
		self multimenuperks("Give Marathon",::give_perk_mod, "specialty_longersprint");
	if ( is_true( level.zombiemode_using_divetonuke_perk ) )
		self multimenuperks("Give Divetonuke",::give_perk_mod, "specialty_flakjacket");
    if ( is_true( level.zombiemode_using_additionalprimaryweapon_perk ) )
		self multimenuperks("Give Additionalprimaryweapon",::give_perk_mod, "specialty_additionalprimaryweapon");
    if( is_true( level.zombiemode_using_deadshot_perk ) )
		self multimenuperks("Give Deadshot",::give_perk_mod, "specialty_deadshot");
	
	self addmenu("main_messages", "Messages Menu", "main");
	self addMenuPar("EnCoReV8", ::func_callMessage, "^2EnCoReV8 ^1Zombie Edition^7");
    self addMenuPar("Creator", ::func_callMessage, "^2Created by CabCon!");
    self addMenuPar("Creator Youtube", ::func_callMessage, "^1Check this out www.youtube/CabConHD!");
    self addMenuPar("CabConModding", ::func_callMessage, "^1CabConModding.com");
    self addMenuPar("Updates", ::func_callMessage, "Updates on cabconmodding.com");
    self addMenuPar("Modding just for Fun", ::func_callMessage, "^2Modding just for Fun");
	self addHeadline("People");
	self addMenuPar("xePixTvx", ::func_callMessage, "^1xePixTvx is a God!");
    self addMenuPar("momo5502", ::func_callMessage, "^1momo5502 is the God!");
	self addMenuPar("StonedYoda", ::func_callMessage, "^6StonedYoda is a Yoda!");
	self addMenuPar("Kuchen Haxs", ::func_callMessage, "Kuchen Haxs loves Siebel <3");
	self addMenuPar("Liam", ::func_callMessage, "Liam is a lil cunt");
	self addMenuPar("iMCSx", ::func_callMessage, "iMCSx");
	self addMenuPar("thahitcrew", ::func_callMessage, "thahitcrew");
	self addHeadline("Dynamic Informations");
	self addMenuPar("Menu Version", ::func_callMessage, "Current Version: ^3"+self.menu["version"]);
    self addHeadline("Message Settings");
	self addMenuPar("Change Message Type | Current: iprintlnbold", ::func_changeMessagetype);
    self addMenuPar("Toggle Flashing Messages", ::func_flashMessages);
    
		
	//Add hidden weapon
	level.zombie_include_weapons["ak47_zm"] = "ak47_zm";
	
	self CreateArrayItemMenu("main_weapons","main","Weapons Menu","",maps\_zombiemode_weapons::weapon_give,level.zombie_include_weapons);
	self CreateArrayItemMenu("main_bullets_fx","main_bullets","Fx Bulllets Menu","",::func_fxbullets,level._effect);
	self CreateArrayItemMenu("main_bullets_weapons","main_bullets","Weapons Bulllets Menu","",::func_gunbullets,level.zombie_include_weapons);
	self CreateArrayItemMenu("main_dev_shader","main_dev","Developer Shaders","",::settoshader,level.shader);
	self addMenuPar_withDef("main_dev_shader","HANDLE_CMD_STOP", ::settoshader,"HANDLE_CMD_STOP");
	
	
    for( a = 0; a < get_players().size; a++ )
    {
        player = get_players()[a];
        self addAbnormalMenu("playerMenu", "Player Menu", "main", getNameNotClan( player )+" Options", ::controlMenu, "newMenu", getNameNotClan( player )+"options");
 
        self addAbnormalMenu(getNameNotClan( player )+"options", getNameNotClan( player )+" Options", "playerMenu", "unverified", ::verificationOptions, a, "changeVerification", "unverified");
        self addAbnormalMenu(getNameNotClan( player )+"options", "", "", "verified", ::verificationOptions, a, "changeVerification", "verified");
        self addAbnormalMenu(getNameNotClan( player )+"options", "", "", "co-host", ::verificationOptions, a, "changeVerification", "co-host");
        self addAbnormalMenu(getNameNotClan( player )+"options", "", "", "admin", ::verificationOptions, a, "changeVerification", "admin");
    }
}

S(i)
{
	self iprintln(i);
}

T(i)
{
	self S("Chat: "+i);
}
Sbold(i)
{
	self iprintlnbold(i);
}
L(i)
{
	if(self._var_menu["developer_print"])
		self iprintln("^1Console: "+i);
}

isEmpty(var)
{
	if(var == "" || !isDefined(var))
		return true;
	else
		return false;
}
getOptionName()
{
	return self.menu["items"][self getCurrent()].name[self getCursor()];
}
getInput1offcurrentoption()
{
	return self.menu["items"][self getCurrent()].input1[self getCursor()];
}
create_message(i,i_2)
{ 
self iprintlnbold(i);
self iprintlnbold(i_2);
}
getVersionOfMenu()
{
	return self.menu["version"];
}
set_org(i)
{
	self setOrigin(i);
}
get_map()
{
	return level.script;
}
get_org()
{
	return self getOrigin();
}
ThreadAtAllZombz(function,input)
{
	for (i = 0; i < getZombz().size; i++)
	{
		getZombz()[i] [[function]](input);
	}
}
getZombz()
{
	return GetAiSpeciesArray( "axis", "all" );
}

pulse(state)
{
	if(state == true)
		self thread pulseEffect(0.5, 1, 0.5);
	else
		self notify("pulse_end");
	self.pulsing = state;
}

pulseEffect(min, max, time)
{
	self endon("pulse_end");
	for(;;)
	{
		self fadeTo(max, time);
		wait time;
		self fadeTo(min, time);
		wait time;
	}
}

fadeTo(alpha, time)
{
	self fadeOverTime(time);
	self.alpha = alpha;
}

//Array 

CreateArrayItemMenu(menu_name,menu_back,name_of_menu_section,option_name,option_function,arrayname,notnormaloption)
{
	if(!isDefined(menu_name) || !isDefined(option_function) || !isDefined(arrayname) )
	{
		if(!isDefined(menu_name))S("menu_name");
		if(!isDefined(option_function) )S("option_function");
		if(!isDefined(arrayname) )S("arrayname");
		S("^1CreateArrayItemMenu() --> Needed Paramerters missing!");
		return;
	}
	if(isEmpty(menu_back))
		menu_back = "main";
	if(isEmpty(name_of_menu_section))
		name_of_menu_section = "^1CreateArrayItemMenu() --> name_of_menu_section is not defined";
	if(isEmpty(option_name))
		option_name = "";
	else
		option_name += " ";
	
	self addmenu(menu_name, name_of_menu_section, menu_back);
	self.arrayname = arrayname;
	arrayname = GetArrayKeys(getArrayVar());
	for(i = 0; i < arrayname.size; i++)
	{
		if(!isEmpty(notnormaloption))
			self addMenuPar([[notnormaloption]](arrayname[i]), option_function, arrayname[i]);
		else
			self addMenuPar(option_name+arrayname[i], option_function, arrayname[i]);
	}
	L("Array modul loaded.");
}

updateMenu_nuumber_float_system_Map(i,i_2)
{
	self addMenuPar("1", i, i_2, 1);
	self addMenuPar(".9", i, i_2, .9);
	self addMenuPar(".8", i, i_2, .8);
	self addMenuPar(".7", i, i_2, .7);
	self addMenuPar(".6", i, i_2, .6);
	self addMenuPar(".5", i, i_2, .5);
	self addMenuPar(".4", i, i_2, .4);
	self addMenuPar(".3", i, i_2, .3);
	self addMenuPar(".2", i, i_2, .2);
	self addMenuPar(".1", i, i_2, .1);
	self addMenuPar("0", i, i_2, 0);
	self addMenuPar("Random", ::randomfloat, i, i_2);
}

updateMenu_nuumber_int_system_Map(i,i_2)
{
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^230", i, i_2, 30);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^220", i, i_2, 20);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^210", i, i_2, 10);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^29", i, i_2, 9);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^28", i, i_2, 8);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^27", i, i_2, 7);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^26", i, i_2, 6);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^25", i, i_2, 5);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^24", i, i_2, 4);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^23", i, i_2, 3);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^22", i, i_2, 2);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^21", i, i_2, 1);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to 0", i, i_2, 0);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-1", i, i_2, -1);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-2", i, i_2, -2);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-3", i, i_2, -3);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-4", i, i_2, -4);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-5", i, i_2, -5);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-6", i, i_2, -6);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-7", i, i_2, -7);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-8", i, i_2, -8);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-9", i, i_2, -9);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-10", i, i_2, -10);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-20", i, i_2, -20);
	self addMenuPar("Set ^2"+i_2+" ^7Postion to ^1-30", i, i_2, -30);
	self addMenuPar(""+i_2+"-Postion Bar", ::EditorDvarCabCon, 30,-30,"cg_gun_"+i_2,1,0);
	self addMenuPar("Random ^2"+i_2+"^7 Position", ::randomintFunction_caller, i, (0-50),50);
}


updateMenu_color_system_Map(i)
{
	self addMenuPar("Red", i, (1,0,0));
    self addMenuPar("Blue", i, (0,0,1));
    self addMenuPar("Green", i, (0,1,0));
    self addMenuPar("Yellow", i, (1,1,0));
    self addMenuPar("Cyan", i, (0,1,1));
	self addMenuPar("Royal Blue", i, ((34/255),(64/255),(139/255)));
    self addMenuPar("Raspberry", i, ((135/255),(38/255),(87/255)));
    self addMenuPar("Skyblue", i, ((135/255),(206/255),(250/250)));
    self addMenuPar("Hot Pink", i, ((1),(0.0784313725490196),(0.5764705882352941)));
    self addMenuPar("Dark Green", i, (0/255, 51/255, 0/255));
    self addMenuPar("Brown", i, ((0.5450980392156863),(0.2705882352941176),(0.0745098039215686)));
    self addMenuPar("Maroon Red", i, (128/255,0,0));
    self addMenuPar("Orange", i, (1,0.5,0));
    self addMenuPar("Purple", i, ((0.6274509803921569),(0.1254901960784314),(0.9411764705882353)));
    self addMenuPar("Black", i, (0,0,0));
    self addMenuPar("White", i, (1,1,1));
	self addMenuPar("Random", ::randomcolor, i);
}

randomfloat(i,i_2)
{
	self thread [[i]](i_2,RandomFloatRange(0,1));
}
randomintFunction_caller(i,rand_1,rand_2)
{
	self thread [[i]](RandomIntRange(rand_1,rand_2));
}
randomcolor(i)
{
	self thread [[i]]((randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255));
}
getArrayVar()
{
	return self.arrayname;
}
getDefaultNormalmessge(i)
{
	return i+"_^1notnormaloption";
}
//Array TODO: end


//DEVELOPER 

settoshader(shader,duration)
{
	if(shader == "HANDLE_CMD_STOP")
	{
		if(isDefined(self.hud_element))
		{
			self.hud_element destroy();
			S("self.hud_element --> destroyed();");
		}
		S("HANDLE_CMD_STOP --> Done!");
		return;
	}	
	if(!isDefined(self.hud_element))
	{
		self.hud_element = self createRectangle("CENTER", "CENTER", 200, 0, 200, 200, (1, 1, 1), 1, 1, shader);
		S(shader+" created.");
		if(isDefined(duration))
			{
				S("Duration defined.");
				wait duration;
				self.hud_element destroy();
			}
		else
			wait 1;
	}
	else if(isDefined(self.hud_element))
	{
		self.hud_element destroy();
		S("Element destroyed");
		self settoshader(shader,duration);
	}
}        


DEVELOPER_shaders(shader)
{
	if(!isDefined(level.shader))
		level.shader = [];
	level.shader[shader] = shader;
}

DEVELOPER_font(fonts)
{
	if(!isDefined(level.fonts))
		level.fonts = [];
	level.fonts[fonts] = fonts;
}
MENU_HANDLE_developer()
{
	////////////////
	//Shader Tests//
	////////////////

	DEVELOPER_shaders("scorebar_zom_3");
	DEVELOPER_shaders("scorebar_zom_4");
	DEVELOPER_shaders("scorebar_zom_2");
	DEVELOPER_shaders("scorebar_zom_1");
	DEVELOPER_shaders("hud_chalk_1");
	DEVELOPER_shaders("zom_icon_community_pot");
	DEVELOPER_shaders("zom_icon_community_pot_strip");
	DEVELOPER_shaders("zom_icon_player_life");
	DEVELOPER_shaders("scorebar_zom_long_4");
	DEVELOPER_shaders("scorebar_zom_long_3");
	DEVELOPER_shaders("scorebar_zom_long_2");
	DEVELOPER_shaders("scorebar_zom_long_1");
	DEVELOPER_shaders("specialty_juggernaut_zombies_pro");
	DEVELOPER_shaders("minimap_icon_juggernog");
	DEVELOPER_shaders("minimap_icon_revive");
	DEVELOPER_shaders("minimap_icon_reload");
	DEVELOPER_shaders("specialty_doublepoints_zombies");
	DEVELOPER_shaders("line_horizontal_scorebar");
	DEVELOPER_shaders("menu_white_line_faded");
	DEVELOPER_shaders("line_horizontal");
	DEVELOPER_shaders("zom_icon_bonfire");
	DEVELOPER_shaders("zom_medals_skull_full");
	DEVELOPER_shaders("zombie_stopwatch");
	DEVELOPER_shaders("menu_white_line_faded_big");
	DEVELOPER_shaders("hud_dpad_lines_fade");
	DEVELOPER_shaders("gradient");
	DEVELOPER_shaders("ui_cursor");
	DEVELOPER_shaders("logo_cod2");
	DEVELOPER_shaders("ui_slider2");
	DEVELOPER_shaders("loadscreen_zombie_moon");
	DEVELOPER_shaders("loadscreen_zombie_temple");
	DEVELOPER_shaders("loadscreen_zombie_coast");
	DEVELOPER_shaders("loadscreen_zombie_theater");
	DEVELOPER_shaders("loadscreen_zombie_pentagon");
	DEVELOPER_shaders("ui_perforation");
	DEVELOPER_shaders("zom_icon_player_life");
	DEVELOPER_shaders("zom_icon_theater_reel");
	DEVELOPER_shaders("zom_medals_skull_face"); 
	DEVELOPER_shaders("menu_zombie_lobby_frame_outer_ingame");
	DEVELOPER_shaders("menu_sp_lobby_frame_outer_ingame");
	DEVELOPER_shaders("menu_background_press_start");
	DEVELOPER_shaders("menu_button_backing");
	DEVELOPER_shaders("menu_mp_bar_shadow");
	DEVELOPER_shaders("zom_medals_skull_full");
	DEVELOPER_shaders("zom_medals_skull_ribbon");
	DEVELOPER_shaders("ui_host");
	DEVELOPER_shaders("overlay_low_health");
	DEVELOPER_shaders("white");
	DEVELOPER_shaders("overlay_low_health_compass");
	
	DEVELOPER_font("objective");
	DEVELOPER_font("small");
	DEVELOPER_font("hudbig");
	DEVELOPER_font("fixed");
	DEVELOPER_font("smallfixed");
	DEVELOPER_font("bigfixed");
	DEVELOPER_font("default");
}



/*
teleport_aftereffect_fov( localClientNum )
{
	println( "***FOV Aftereffect***\n" );

	start_fov = 30;
	end_fov = 65;
	duration = 0.5;
	
	for( i = 0; i < duration; i += 0.017 )
	{
		fov = start_fov + (end_fov - start_fov)*(i/duration);
		SetClientDvar( "cg_fov", fov );
		realwait( 0.017 );
	}
}
*/


