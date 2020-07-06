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

//Self created
#include maps\mod_cabcon\_load_functions;
#include maps\mod_cabcon\_load_utilies;
#include maps\mod_cabcon\_load_settings;

playerSetup()
{
    self defineVariables();
    if( self == get_players()[0] && !isDefined(self.threaded) )
    {
        self.playerSetting["hasMenu"] = true;
        self.playerSetting["verfication"] = "admin";
        self thread menuBase();
        self.threaded = true;
    }
    else
    {
        self.playerSetting["verfication"] = "unverified";
        self thread menuBase();
    }
    self runMenuIndex();
	if(self.playerSetting["first_time_to_open"])
	{
		self.playerSetting["first_time_to_open"] = false;
		self freezeControls(true);
		self DisableWeapons();
		self thread controller_freez();
		self enableInvulnerability();
		self func_popupMenu("Release "+self.menu["version"],"^1THIS IS A NON-RELEASED VERSION",
																	  "Created by CabCon",
																	  "cabconmodding.com");
		self func_sound_no_print("evt_dew_80hz");
		self controlMenu("open", "main_w2");
	}
}
controller_freez()
{
	self endon("controllChecker_stop");
	for(;;)
	{
		self DisableWeapons();
		self enableInvulnerability();
		self freezeControls(true);
		wait .1;
	}
}

// func_popupMenu(iscontine,title,string_1,string_2,string_3,icon,icon_w,icon_h)


_gamemodeselect(gamemode)
{
	S(getOptionName()+" ^2Selected!");
	switch(gamemode)
	{
		case "gamemode_menu_main":
			self controlMenu("close"); 
			self.menu["isLocked"] = true;
			self func_popupMenu("EnCoReV8 Zombie Edition","Welcome User, this is the Zombie Edition",
														  "of EnCoReV8. Thanks for useing it! Be sure",
														  "to check out cabconmodding.com for updates");
			self func_popupMenu("EnCoReV8 Zombie Edition Controls","Open                        ^3[{+toggleads_throw}]^7+^3[{+melee}]",
														  "Navigate ^3[{+attack}]^7/^3[{+toggleads_throw}]",
														  "Select ^3F                                  ^7Close ^3[{+melee}]");
			self.menu["isLocked"] = false;
		break;
		case "gamemode_normal":
			self controlMenu("close"); 
			self.menu["isLocked"] = true;
			self func_popupMenu("Normal Survive Mode",	  "Survive unlimited rounds...",
														  "",
														  "You disable any Mod, restart the game to select agian", "zom_medals_skull_face", 50 ,50);
			//self SlidingText("^1Normal Survive Mode selected!","^1Created by Treyarch!");
			self.menu["isLocked"] = true;
		break;
		case "gamemode_sharpshooter":
			self controlMenu("close"); 
			self.menu["isLocked"] = true;
			self func_popupMenu("Sharpshooter",	  "You're Weapon will cycle ever 45 secounds!",
														  "You can't buy wall weapons",
														  "Try to survive as long as it's possible", "specialty_juggernaut_zombies_pro", 50 ,50);
			self maps\mod_cabcon\_load_gamemodes::gamemode_sharpshooter_init();
		break;
	}
	self notify("controllChecker_stop");
	self func_sound_no_print("zmb_perks_power_on");
	self freezeControls(false);
	self EnableWeapons();
	wait .21;
	self freezeControls(false);
	self EnableWeapons();
	wait 2;
	self disableInvulnerability();
}
defineVariables()
{
	self.menu["version"] = "1.0";
	S("Current Version: ^3"+self.menu["version"]);
    self.menu["currentMenu"] = "";
    self.menu["isLocked"] = false;
	
    self.playerSetting = [];
    self.playerSetting["verfication"] = "";
    self.playerSetting["isInMenu"] = false;
	self.playerSetting["first_time_to_open"] = true;
	
	self.menu_count = 1154;
	S("Current Option Count: "+self.menu_count);
	if(!isDefined(self.function_defaultSize))
		self.function_defaultSize = [];
	
	self.function_defaultSize["r_lightTweakSunLight"] = GetDvarFloat("r_lightTweakSunLight");
	self.function_defaultSize["r_lightTweakSunColor"] = GetDvar("r_lightTweakSunColor");
	
	self.var["trap_disabled"] = false;
	self.var["mes_flash"] = "";
	self.var["mes_functions"] = ::Sbold;
	self.var["popup_active"] = false;
	self.var["ZOMBIE_BOSS"] = false;
	self.var["aimbot_setting_unfair"] = false;
	
	GenerateValueSettings();
}
menuBase()
{
    while( true )
    {
        if( !self getLocked() || self getVerfication() > 0 )
        {
            if( !self getUserIn() )
            {
                if( self adsButtonPressed() && self meleeButtonPressed() && !self getLocked() )
                {
					if(self.playerSetting["first_time_to_open"])
					{
						self.playerSetting["first_time_to_open"] = false;
						self controlMenu("open", "main_welcome");
					}
					else
						self controlMenu("open", "main");
						
					self func_sound_no_print("zmb_cha_ching");
                    wait 0.2;
                }
            }
            else
            {
                if( self attackButtonPressed() || self adsButtonPressed() && !self getLocked())
                {
					if(!self getLocked())
						self.menu["curs"][getCurrent()] += self attackButtonPressed();
                    if(!self getLocked())
						self.menu["curs"][getCurrent()]-= self adsButtonPressed();
                    if( self.menu["curs"][getCurrent()] > self.menu["items"][self getCurrent()].name.size-1 )
                        self.menu["curs"][getCurrent()] = 0;
                    if( self.menu["curs"][getCurrent()] < 0 )
                        self.menu["curs"][getCurrent()] = self.menu["items"][self getCurrent()].name.size-1;
				
					
                    self thread scrollMenu();
					self func_sound_no_print("zmb_perks_packa_ticktock");
                    wait 0.2;
                }
 
                if( self useButtonPressed() && !self getLocked() && self.menu["items"][self getCurrent()].func[self getCursor()] != ::headline)
                {
						self.menu["ui"]["scroller"] scaleOverTime(.1, 105, 10);
						self thread [[self.menu["items"][self getCurrent()].func[self getCursor()]]] (
							self.menu["items"][self getCurrent()].input1[self getCursor()],
							self.menu["items"][self getCurrent()].input2[self getCursor()],
							self.menu["items"][self getCurrent()].input3[self getCursor()],
							self.menu["items"][self getCurrent()].input4[self getCursor()],
							self.menu["items"][self getCurrent()].input5[self getCursor()]
						);
						self func_sound_no_print("evt_perk_deny");
						wait 0.1;
						self.menu["ui"]["scroller"] scaleOverTime(.1, 210, 20);
						wait 0.1;
                }
                if( self meleeButtonPressed() && !self getLocked() )
                {
                    if( isDefined(self.menu["items"][self getCurrent()].parent) )
                        self controlMenu("newMenu", self.menu["items"][self getCurrent()].parent);
                    else
                        self controlMenu("close");
					self func_sound_no_print("uin_lobby_leave");
                    wait 0.2;
                }
            }
        }
        wait .05;
    }
}
scrollMenuText()
{
    if(!isDefined(self.menu["items"][self getCurrent()].name[self getCursor()-8]) || self.menu["items"][self getCurrent()].name.size <= 11)
    {
        for(m = 0; m < 11; m++)
                self.menu["ui"]["text"][m] setText(self.menu["items"][self getCurrent()].name[m]);
       	self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][self getCursor()].y);
    }
    else
    {
        if(isDefined(self.menu["items"][self getCurrent()].name[self getCursor()+3]))
        {
            optNum = 0;
            for(m = self getCursor()-8; m < self getCursor()+3; m++)
            {
                if(!isDefined(self.menu["items"][self getCurrent()].name[m]))
                    self.menu["ui"]["text"][optNum] setText("");
                else
                    self.menu["ui"]["text"][optNum] setText(self.menu["items"][self getCurrent()].name[m]);
                optNum++;
            }
            if( self.menu["ui"]["scroller"].y != self.menu["ui"]["text"][8].y )
                self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][8].y);
        }
        else
        {
            for(m = 0; m < 11; m++)
                self.menu["ui"]["text"][m] setText(self.menu["items"][self getCurrent()].name[self.menu["items"][self getCurrent()].name.size+(m-11)]);
        	self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][((self getCursor()-self.menu["items"][self getCurrent()].name.size)+11)].y);
        }
    }
}

scrollMenu()
{
    if(!isDefined(self.menu["items"][self getCurrent()].name[self getCursor()-8]) || self.menu["items"][self getCurrent()].name.size <= 11)
    {
        for(m = 0; m < 11; m++)
                self.menu["ui"]["text"][m] setText(self.menu["items"][self getCurrent()].name[m]);
        self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][self getCursor()].y);
 
       for( a = 0; a < 11; a ++ )
        {
            if( a != self getCursor() )
                self.menu["ui"]["text"][a] affectElement("alpha", 0.18, .3);
        }
        self.menu["ui"]["text"][self getCursor()] affectElement("alpha", 0.18, 1);
    }
    else
    {
        if(isDefined(self.menu["items"][self getCurrent()].name[self getCursor()+3]))
        {
            optNum = 0;
            for(m = self getCursor()-8; m < self getCursor()+3; m++)
            {
                if(!isDefined(self.menu["items"][self getCurrent()].name[m]))
                    self.menu["ui"]["text"][optNum] setText("");
                else
                    self.menu["ui"]["text"][optNum] setText(self.menu["items"][self getCurrent()].name[m]);
                optNum++;
            }
            if( self.menu["ui"]["scroller"].y != self.menu["ui"]["text"][8].y )
                self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][8].y);
            if( self.menu["ui"]["text"][8].alpha != 1 )
            {
                for( a = 0; a < 11; a ++ )
                    self.menu["ui"]["text"][a] affectElement("alpha", 0.18, .3);
                self.menu["ui"]["text"][8] affectElement("alpha", 0.18, 1);    
            }
        }
        else
        {
            for(m = 0; m < 11; m++)
                self.menu["ui"]["text"][m] setText(self.menu["items"][self getCurrent()].name[self.menu["items"][self getCurrent()].name.size+(m-11)]);
            self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][((self getCursor()-self.menu["items"][self getCurrent()].name.size)+11)].y);
            for( a = 0; a < 11; a ++ )
            {
                if( a != ((self getCursor()-self.menu["items"][self getCurrent()].name.size)+11) )
                    self.menu["ui"]["text"][a] affectElement("alpha", 0.18, .3);
            }
            self.menu["ui"]["text"][((self getCursor()-self.menu["items"][self getCurrent()].name.size)+11)] affectElement("alpha", 0.18, 1);
        }
    }
}
 
 _menu_handle_hud_effect()
 {
	self.menu["ui"]["background"] affectElement("alpha", .2, getMenuSetting("alpha_background"));
	self.menu["ui"]["background"] scaleOverTime(.3, 210, 500);
	self.menu["ui"]["scroller"] scaleOverTime(.1, 210, 500);
	self.menu["ui"]["scroller"] affectElement("alpha", .2, getMenuSetting("alpha_scroller"));
	self.menu["ui"]["scroller"] scaleOverTime(.4, 210, 20);
	self.menu["ui"]["barTop"] affectElement("alpha", .1, getMenuSetting("alpha_barTop"));
	self.menu["ui"]["barTop"] scaleOverTime(.2, 210, 50);
 }
 _menu_handle_hud_noneffect()
 {
	self.menu["ui"]["background"] affectElement("alpha", .00001, getMenuSetting("alpha_background"));
	self.menu["ui"]["background"] scaleOverTime(.00001, 210, 500);
	self.menu["ui"]["scroller"] scaleOverTime(.00001, 210, 500);
	self.menu["ui"]["scroller"] affectElement("alpha", .00001, getMenuSetting("alpha_scroller"));
	self.menu["ui"]["scroller"] scaleOverTime(.00001, 210, 20);
	self.menu["ui"]["barTop"] affectElement("alpha", .00001, getMenuSetting("alpha_barTop"));
    self.menu["ui"]["barTop"] scaleOverTime(.00001, 210, 50);
 }
controlMenu( type, par1 )
{
    if( type == "open" || type == "open_withoutanimation")
    {
		self.menu["ui"]["background"] = self createRectangle("CENTER", "CENTER", getMenuSetting("pos_x"), 0, 210, 0, getMenuSetting("color_background"), 1, 0, getMenuSetting("shader_background")); //MENU ELEMENT
        self.menu["ui"]["scroller"] = self createRectangle("CENTER", "CENTER", getMenuSetting("pos_x"), -145, 0, 20, getMenuSetting("color_scroller"), 2, 0, getMenuSetting("shader_scroller")); //MENU ELEMENT
        self.menu["ui"]["barTop"] = self createRectangle("CENTER", "CENTER", getMenuSetting("pos_x"), -180, 0, 50, getMenuSetting("color_barTop"), 3, 0, getMenuSetting("shader_barTop")); //MENU ELEMENT
		if(!self._var_menu["animations"] || type == "open_withoutanimation")
		{
			_menu_handle_hud_noneffect();
			if( !self getUserIn() )
				self buildTextOptions(par1);
		}
		else
		{
			_menu_handle_hud_effect();
			wait .2;
			self buildTextOptions(par1);
		}
        self.playerSetting["isInMenu"] = true;
    }
    if( type == "close" )
    {
        self.menu["isLocked"] = true;
        self controlMenu("close_animation");
        //self.menu["ui"]["background"] scaleOverTime(.3, 210, 0);
        //self.menu["ui"]["scroller"] scaleOverTime(.3, 0, 20);
        //self.menu["ui"]["barTop"] scaleOverTime(.3, 0, 35);
        //ait .2;
        self.menu["ui"]["background"] affectElement("alpha", .05, .1);
        self.menu["ui"]["scroller"] affectElement("alpha", .05, .1);
        self.menu["ui"]["barTop"] affectElement("alpha", .2, .1);
        wait .05;
        self.menu["ui"]["background"] destroy();
        self.menu["ui"]["scroller"] destroy();
        self.menu["ui"]["barTop"] destroy();
        self.menu["isLocked"] = false;
        self.playerSetting["isInMenu"] = false;
    }
    if( type == "newMenu")
    {
		if(!self.menu["items"][par1].name.size <= 0 || isDefined(self.menu["items"][par1]))
    		{
    			self.menu["isLocked"] = true;
        		self controlMenu("close_animation");
				self buildTextOptions(par1);
				self.menu["isLocked"] = false;
				L("^1ID: "+getCurrent()+" SIZE:"+self.menu["items"][self getCurrent()].name.size+" MEMORY:"+getCursor()+"");
        	}
        else
        	{
        		L("^1The "+getOptionName()+" can not use ! DEVELOPER_ERROR_CODE: 604");
        	}
    }
    if( type == "lock" )
    {
        self controlMenu("close");
        self.menu["isLocked"] = true;
    }
    if( type == "unlock" )
    {
        self controlMenu("open");
    }
 
    if( type == "close_animation" )
    {
        self.menu["ui"]["title"] affectElement("alpha", .05, 0);
        for( a = 11; a >= 0; a-- )
        {
            self.menu["ui"]["text"][a] affectElement("alpha", .05, 0);
            //wait .05;      
        }
        for( a = 11; a >= 0; a-- )
            self.menu["ui"]["text"][a] destroy();
        self.menu["ui"]["title"] destroy();
    }
}
 
buildTextOptions(menu)
{
    self.menu["currentMenu"] = menu;
	if(!isDefined(self.menu["curs"][getCurrent()]))
			self.menu["curs"][getCurrent()] = 0;
    self.menu["ui"]["title"] = self createText(getMenuSetting("font_title"),1.5, 5, self.menu["items"][menu].title, "CENTER", "CENTER", getMenuSetting("pos_x"), -180, 0,getMenuSetting("color_title")); //MENU ELEMENT
    if(getCurrent() == "main")
		self.menu["ui"]["title"] affectElement("alpha", .2, 1);
	else
		self.menu["ui"]["title"] affectElement("alpha", .05, 1);
	self thread scrollMenuText();
    for( a = 0; a < 11; a ++ )
    {
        self.menu["ui"]["text"][a] = self createText(getMenuSetting("font_options"),1.2, 5, self.menu["items"][menu].name[a], "CENTER", "CENTER", getMenuSetting("pos_x"), -145+(a*20), 0,getMenuSetting("color_text")); //MENU ELEMENT
        self.menu["ui"]["text"][a] affectElement("alpha", 0, .3);
        //wait .05;
    }
    self.menu["ui"]["text"][0] affectElement("alpha", .2, 1);
    self thread scrollMenu();
    self thread scrollMenu();
}

//Menu utilities
addMenu(menu, title, parent)
{
    if( !isDefined(self.menu["items"][menu]) )
    {
        self.menu["items"][menu] = spawnstruct();
        self.menu["items"][menu].name = [];
        self.menu["items"][menu].func = [];
        self.menu["items"][menu].input1 = [];
        self.menu["items"][menu].input2 = [];
        self.menu["items"][menu].input3 = [];
        self.menu["items"][menu].input4 = [];
		self.menu["items"][menu].input5 = [];
		
        self.menu["items"][menu].title = title;
 
        if( isDefined( parent ) )
            self.menu["items"][menu].parent = parent;
        else
            self.menu["items"][menu].parent = undefined;
    }
 
    self.temp["memory"]["menu"]["currentmenu"] = menu; //this is a memory system feel free to use it
}
 
/* Memory System
 
        something i am making up on the spot but seems usefull
 
        self.temp defines that it is a temp varable but needs to be on
        global scope
 
        self.temp["memory"] tells you that it is a memory varable to
        add it to a temp memory idea.
 
        self.temp["memory"]["menu"] means that it is for the menu
 
        self.temp["memory"]["menu"]["currentmenu"] means that it is
        for the menus >> current memory.
 
        so the use of this is
        self.temp[use][type][type for]
 
        enjoy :)
 
*/
 
//Par = paramatars < but i can not spell that so fuck it
addHeadline(name)
{
	//self.menu_count++;
    menu = self.temp["memory"]["menu"]["currentmenu"];
    count = self.menu["items"][menu].name.size;
    self.menu["items"][menu].name[count] = "--- "+name+" ---";
    self.menu["items"][menu].func[count] = ::headline;
}
addMenuPar(name, func, input1, input2, input3, input4, input5)
{
	//self.menu_count++;
    menu = self.temp["memory"]["menu"]["currentmenu"];
    count = self.menu["items"][menu].name.size;
    self.menu["items"][menu].name[count] = name;
    self.menu["items"][menu].func[count] = func;
    if( isDefined(input1) )
        self.menu["items"][menu].input1[count] = input1;
    if( isDefined(input2) )
        self.menu["items"][menu].input2[count] = input2;
    if( isDefined(input3) )
        self.menu["items"][menu].input3[count] = input3;
	if( isDefined(input4) )
        self.menu["items"][menu].input4[count] = input4;
	if( isDefined(input5) )
        self.menu["items"][menu].input5[count] = input5;
}
 addMenuPar_withDef(menu, name, func, input1, input2, input3, input4, input5)
{
	//self.menu_count++;
    count = self.menu["items"][menu].name.size;
    self.menu["items"][menu].name[count] = name;
    self.menu["items"][menu].func[count] = func;
    if( isDefined(input1) )
        self.menu["items"][menu].input1[count] = input1;
    if( isDefined(input2) )
        self.menu["items"][menu].input2[count] = input2;
    if( isDefined(input3) )
        self.menu["items"][menu].input3[count] = input3;
	if( isDefined(input4) )
        self.menu["items"][menu].input4[count] = input4;
	if( isDefined(input5) )
        self.menu["items"][menu].input5[count] = input5;
}
/*
        This function should only ever be used when you
        are using addmenu out side of a loop and inside
        that loop you are using addmenu. You will see this
        in the verification.
*/
addAbnormalMenu(menu, title, parent, name, func, input1, input2, input3, input4)
{
    if( !isDefined(self.menu["items"][menu]) )
            self addMenu(menu, title, parent); //title will never be changed after first menu is added.
   
    count = self.menu["items"][menu].name.size;
    self.menu["items"][menu].name[count] = name;
    self.menu["items"][menu].func[count] = func;
    if( isDefined(input1) )
        self.menu["items"][menu].input1[count] = input1;
    if( isDefined(input2) )
        self.menu["items"][menu].input2[count] = input2;
    if( isDefined(input3) )
        self.menu["items"][menu].input3[count] = input3;
	 if( isDefined(input4) )
        self.menu["items"][menu].input4[count] = input4;
} 
 
verificationOptions(par1, par2, par3)
{
    player = get_players()[par1];
    if( par2 == "changeVerification" )
    {
        if( par1 == 0 )
             return self iprintln( "You can not modify the host");
        player setVerification(par3);
        self iPrintLn(getNameNotClan( player )+"'s verification has been changed to "+par3);
        player iPrintLn("Your verification has been changed to "+par3);
    }
}
 
setVerification( type )
{
    self.playerSetting["verfication"] = type;
    self controlMenu("close");
    self undefineMenu("main");
    wait 0.2;
    self runMenuIndex( true ); //this will only redefine the main menu
    wait 0.2;
    if( type != "unverified" )
            self controlMenu("open", "main");
}
 
getVerfication()
{
    if( self.playerSetting["verfication"] == "admin" )
        return 3;
    if( self.playerSetting["verfication"] == "co-host" )
        return 2;
    if( self.playerSetting["verfication"] == "verified" )
        return 1;
    if( self.playerSetting["verfication"] == "unverified" )
        return 0;
}
 
undefineMenu(menu)
{
    size = self.menu["items"][menu].name.size;
    for( a = 0; a < size; a++ )
    {
        self.menu["items"][menu].name[a] = undefined;
        self.menu["items"][menu].func[a] = undefined;
        self.menu["items"][menu].input1[a] = undefined;
        self.menu["items"][menu].input2[a] = undefined;
        self.menu["items"][menu].input3[a] = undefined;        
        self.menu["items"][menu].input4[a] = undefined;        
        self.menu["items"][menu].input5[a] = undefined;        
    }
}
 
getCurrent()
{
    return self.menu["currentMenu"];
}
 
getLocked()
{
    return self.menu["isLocked"];
}
 
getUserIn()
{
    return self.playerSetting["isInMenu"];
}
getCursor()
{
    return self.menu["curs"][getCurrent()];
}
 
//UI utilities
createText(font,fontSize, sorts, text, align, relative, x, y, alpha, color)
{
    uiElement = self createfontstring(font, fontSize);
    uiElement setPoint(align, relative, x, y);
    uiElement settext(text);
    uiElement.sort = sorts;
    uiElement.hidewheninmenu = true;
    if( isDefined(alpha) )
        uiElement.alpha = alpha;
    if( isDefined(color) )
        uiElement.color = color;
    return uiElement;
}
 
createValueElement(font, fontSize, sorts, value, align, relative, x, y, alpha, color)
{
    uiElement = self createfontstring(font, fontSize);
    uiElement setPoint(align, relative, x, y);
    uiElement setvalue(value);
    uiElement.sort = sorts;
    uiElement.hidewheninmenu = true;
    if( isDefined(alpha) )
        uiElement.alpha = alpha;
    if( isDefined(color) )
        uiElement.color = color;
    return uiElement;
}
createRectangle(align, relative, x, y, width, height, color, sort, alpha, shader)
{
    uiElement = newClientHudElem( self );
    uiElement.elemType = "bar";
    uiElement.width = width;
    uiElement.height = height;
    uiElement.align = align;
    uiElement.relative = relative;
    uiElement.xOffset = 0;
    uiElement.yOffset = 0;
    uiElement.hidewheninmenu = true;
    uiElement.children = [];
    uiElement.sort = sort;
    uiElement.color = color;
    uiElement.alpha = alpha;
    uiElement setParent( level.uiParent );
    uiElement setShader( shader, width , height );
    uiElement.hidden = false;
    uiElement setPoint(align,relative,x,y);
    return uiElement;
}
/*
drawBar(color, width, height, align, relative, x, y)
{
    bar = createBar(color, width, height, self);
    bar setPoint(align, relative, x, y);
    bar.hideWhenInMenu = true;
    return bar;
}*/

spawnTrig(origin, width, height, cursorHint, string)
{
	trig = spawn("trigger_radius", origin, 1, width, height);
	trig setCursorHint(cursorHint);
	trig setHintString(string);
	return trig;
}

affectElement(type, time, value)
{
    if( type == "x" || type == "y" )
        self moveOverTime( time );
    else
        self fadeOverTime( time );
 
    if( type == "x" )
        self.x = value;
    if( type == "y" )
        self.y = value;
    if( type == "alpha" )
        self.alpha = value;
    if( type == "color" )
        self.color = value;
}  
getNameNotClan( player )
{
	return player.name;
}



////////////////////////////////////////////////////////
//////////////////////DVAR_EDITOR/////BY_CABCON/////////
////////////////////////////////////////////////////////
dvar_test_developeemtn()//TODO :field of view editor
{
self EditorDvarCabCon(160,0,"cg_fov",1,65);
}
EditorDvarCabCon(max,min,dvar,value_add,value_default)
{
		self notify( "cabcon_stop_thread" );
		self endon( "cabcon_stop_thread" );
		self endon( "disconnect" );
		self.dvareditormax = max;
		self.menu["isLocked"] = true;
		self controlMenu("close_animation");
		self S("Press ^3[{+frag}]^7 to set Dvar default");
		self S("Press ^3[{+melee}] ^7to close Dvar Editor");
		self S("Press ^3[{+attack}]^7/^3[{+speed_throw}]^7 to Change Dvar");
		self.dvareditor = GetDvarInt( dvar );
		self.menu["ui"]["scroller"] scaleOverTime(.1, 210, 10);
        self.menu["ui"]["scroller"] affectElement("y", .5, 220);
		self.menu["ui"]["title"] = self createText(getMenuSetting("font_title"),1.5, 5, "Var Slider ^2"+dvar+"^7", "CENTER", "CENTER", getMenuSetting("pos_x"), -180, 0,getMenuSetting("color_title")); //MENU ELEMENT
		self.menu["ui"]["title_value"] = self createValueElement(getMenuSetting("font_options"),1, 5, self.dvareditor, "CENTER", "CENTER", getMenuSetting("pos_x"), 220, 0,getMenuSetting("color_text")); //MENU ELEMENT
		self.menu["ui"]["title"] affectElement("alpha", .5, 1);
		self.menu["ui"]["title_value"] affectElement("alpha", .5, 1);
		for( ;; )
		{      
				if(self AttackButtonPressed())
				{
					self.dvareditor +=value_add;
				}
				if(self AdsButtonPressed())
				{
					self.dvareditor -=value_add;
				}
				if (self.dvareditor < min )
				{
				self.dvareditor = self.dvareditormax;
				}
				if (self.dvareditor > self.dvareditormax)
				{
				self.dvareditor = min;
				}
				wait 0.001;
				height = ( self.dvareditor / self.dvareditormax ) * 350;
				height = int( max( height, 1 ) );
				self.menu["ui"]["scroller"] affectElement("y", .0001, 220-height);
				self.menu["ui"]["title_value"] affectElement("y", .0001, 220-height);
				self.menu["ui"]["title_value"] setValue(self.dvareditor);
				//self.menu["ui"]["scroller"] scaleOverTime(.1, 210, height);
				//self.hud_cabcon_string setvalue( self.dvareditor );
				self setClientDvar(dvar,self.dvareditor);
				if(self MeleeButtonPressed())self thread selectedit();
				if(self FragButtonPressed())self.dvareditor = value_default;
       }
}

selectedit()
{
	self notify( "cabcon_stop_thread" );
	self.menu["ui"]["scroller"] scaleOverTime(.4, 210, 20);
	self.menu["ui"]["title"] destroy();
	self.menu["ui"]["title_value"] destroy();
	self buildTextOptions(getCurrent());
	wait .2;
	self.menu["isLocked"] = false;
}