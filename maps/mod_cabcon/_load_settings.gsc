/*
▒█▀▀▀ █▀▀▄ ▒█▀▀█ █▀▀█ ▒█▀▀█ █▀▀ ▒█░░▒█ ▄▀▀▄ 
▒█▀▀▀ █░░█ ▒█░░░ █░░█ ▒█▄▄▀ █▀▀ ░▒█▒█░ ▄▀▀▄ 
▒█▄▄▄ ▀░░▀ ▒█▄▄█ ▀▀▀▀ ▒█░▒█ ▀▀▀ ░░▀▄▀░ ▀▄▄▀

This is created by cabconmodding.com!

Please just edit it with permission!

*/



#include maps\mod_cabcon\_load_menubase;
#include maps\mod_cabcon\_load_utilies;


GenerateValueSettings()
{
	if(!isDefined(self._var_menu))
		self._var_menu = [];
	
	//VALUES DEFAULT
	self._var_menu["pos_x"] = 200;
	
	self._var_menu["shader_background"] = "white";
	self._var_menu["shader_scroller"] = "white";
	self._var_menu["shader_barTop"] = "white";
	
	self._var_menu["color_title"] = (1, 1, 1);
	self._var_menu["color_text"] = (1, 1, 1);
	
	self._var_menu["color_background"] = (0, 0, 0);
	self._var_menu["color_scroller"] = (.8, 0, 0);
	self._var_menu["color_barTop"] = (.8, 0, 0);
	
	self._var_menu["alpha_background"] = 0.5;
	self._var_menu["alpha_scroller"] = 0.5;
	self._var_menu["alpha_barTop"] = 0.8;
	
	self._var_menu["font_title"] = "default";
	self._var_menu["font_options"] = "default";
	
	
	self._var_menu["animations"] = true;
	self._var_menu["developer_print"] = false;
	
	//Special Values
	self._var_menu["sound_in_menu"] = true;
	

	L("Loaded");
}
switchDesignTemplates(name)
{
	switch(name)
	{
		case "default":
			self menuEventSetMultiParameter(200,"white","white","white",(1, 1, 1),(1, 1, 1),(0, 0, 0),(.8, 0, 0),(.8, 0, 0),0.5,0.5,0.8,"default","default",true,false);
			updateMenuSettings();
			S("Desing set to ^2"+getOptionName());
		break;
		case "saved_1":
			self menuEventSetMultiParameter(200,"gradient","ui_slider2","ui_slider2",(1, 1, 1),(1, 1, 1),(0, 0, 0),(1, 0, 0),(1, 0, 0),0.7,1,1,"small","small",true,false);
			updateMenuSettings();
			S("Desing set to ^2"+getOptionName());
		break;
		case "saved_2":
			self menuEventSetMultiParameter(0,"zom_icon_bonfire","scorebar_zom_long_1","scorebar_zom_long_2",(1, 1, 1),(1, 1, 1),(0, 0, 0),(0.8, 0, 0),(0.8, 0, 0),0.7,0.8,0.8,"objective","objective",false,false);
			updateMenuSettings();
			S("Desing set to ^2"+getOptionName());
		break;
		case "saved_3":
			self menuEventSetMultiParameter(0,"zom_medals_skull_ribbon","line_horizontal","overlay_low_health_compass",(1, 0, 0),(1, 1, 1),(0, 0, 0),(0.502, 0, 0),(1, 1, 1),0.7,0.7,1,"hudbig","hudbig",true,false);
			updateMenuSettings();
			S("Desing set to ^2"+getOptionName());
		break;
		case "saved_4":
			self menuEventSetMultiParameter(220,"white","scorebar_zom_long_1","scorebar_zom_long_1",(1, 1, 1),(1, 1, 1),(0, 0, 0),(.8, 0, 0),(.8, 0, 0),0.5,0.5,1,"default","default",false,false);
			updateMenuSettings();
			S("Desing set to ^2"+getOptionName());
		break;
		case "saved_5":
			self menuEventSetMultiParameter(0,"menu_zombie_lobby_frame_outer_ingame","menu_zombie_lobby_frame_outer_ingame","menu_zombie_lobby_frame_outer_ingame",(1, 1, 1),(1, 1, 1),(0.502, 0, 0),(1, 0, 0),(1, 0, 0),1,1,0,"small","small",false,false);
			updateMenuSettings();
			S("Desing set to ^2"+getOptionName());
		break;
		case "random":
			array_caller = GetArrayKeys(level.shader);
			array_caller_fonts = GetArrayKeys(level.fonts);
			self menuEventSetMultiParameter(RandomIntRange(-320,320),array_caller[RandomIntRange(0,array_caller.size)],array_caller[RandomIntRange(0,array_caller.size)],array_caller[RandomIntRange(0,array_caller.size)],(randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255),(randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255),(randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255),(randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255),(randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255,randomintrange( 0, 255 )/255),randomfloatrange( 0, 1 ),randomfloatrange( 0, 1 ),randomfloatrange( 0, 1 ),array_caller_fonts[RandomIntRange(0,array_caller_fonts.size)],array_caller_fonts[RandomIntRange(0,array_caller_fonts.size)],true,false);
			updateMenuSettings();
			S("Desing set to ^2"+getOptionName());
		break;
		default:
		S("^1Your Design is not defined!");
		break;
	}
}

menuEventSetMultiParameter(pos_x,shader_background,shader_scroller,shader_barTop,color_title,color_text,color_background,color_scroller,color_barTop,alpha_background,alpha_scroller,alpha_barTop,font_title,font_options,animations,developer_print)
{
	self._var_menu["pos_x"] = pos_x;
	
	self._var_menu["shader_background"] = shader_background;
	self._var_menu["shader_scroller"] = shader_scroller;
	self._var_menu["shader_barTop"] = shader_barTop;
	
	self._var_menu["color_title"] = color_title;
	self._var_menu["color_text"] = color_text;
	
	self._var_menu["color_background"] = color_background;
	self._var_menu["color_scroller"] = color_scroller;
	self._var_menu["color_barTop"] = color_barTop;
	
	self._var_menu["alpha_background"] = alpha_background;
	self._var_menu["alpha_scroller"] = alpha_scroller;
	self._var_menu["alpha_barTop"] = alpha_barTop;
	
	self._var_menu["font_title"] = font_title;
	self._var_menu["font_options"] = font_options;
	
	
	self._var_menu["animations"] = animations;
	self._var_menu["developer_print"] = developer_print;
}
givePar_Theme()
{
	S("^2Theme Dump");
	S("^2//");
	S(getMenuSetting("pos_x")+" - "+getMenuSetting("shader_background")+" - "+getMenuSetting("shader_scroller")+" - "+getMenuSetting("shader_barTop")+" - "+getMenuSetting("color_title")+" - "+getMenuSetting("color_text")+" - "+getMenuSetting("color_background")+" - "+getMenuSetting("color_scroller")+" - "+getMenuSetting("color_barTop")+" - "+getMenuSetting("alpha_background")+" - "+getMenuSetting("alpha_scroller")+" - "+getMenuSetting("alpha_barTop")+" - "+getMenuSetting("font_title")+" - "+getMenuSetting("font_options")+" - "+getMenuSetting("animations")+" - "+getMenuSetting("developer_print"));
	S("^2\\");
	S("Dumped in the Log. (check console for more informations)");
}


setTogglerFunction(i)
{
	self._var_menu[i] = !self._var_menu[i];
	S(i+" set to ^2"+ self._var_menu[i]);
}

getMenuSetting(i)
{
	if(!isDefined(self._var_menu[i]))
		return "undefined";
	else
		return self._var_menu[i];
}

setMenuSetting(i,value)
{
	if(IsSubStr(i, "pos"))
	{
		self._var_menu[i] = getMenuSetting(i) + value;
		S("X Position ^2"+getMenuSetting(i));
	}
	else if(IsSubStr(i, "color"))
	{
		self._var_menu[i] = value;
	}
	else if(IsSubStr(i, "alpha"))
	{
		self._var_menu[i] = value;
	}
	else if(IsSubStr(i, "shader"))
	{
		self._var_menu[i] = value;
	}
	else if(IsSubStr(i, "font"))
	{
		self._var_menu[i] = value;
	}
	else
	{
		S("^1This Value is not defined in any type!");
		self._var_menu[i] = value;
	}
	S(i+" set to ^2"+value);
	updateMenuSettings();
}

updateMenuSettings()
{
	self.menu["isLocked"] = true;
	self.menu["ui"]["background"] destroy();
    self.menu["ui"]["scroller"] destroy();
    self.menu["ui"]["barTop"] destroy();

	controlMenu( "open_withoutanimation" );
	controlMenu( "newMenu", getCurrent() );
}


///------------------------------
///Extras
///------------------------------
headline()
{
	
}
setMenuSetting_ThemeColor(i)
{
	setMenuSetting("color_scroller",i);
	setMenuSetting("color_barTop",i);
}
setMenuSetting_color_scroller(i)
{
	setMenuSetting("color_scroller",i);
}
setMenuSetting_color_barTop(i)
{
	setMenuSetting("color_barTop",i);
}
setMenuSetting_TopTextColor(i)
{
	setMenuSetting("color_title",i);
}
setMenuSetting_TextColor(i)
{
	setMenuSetting("color_text",i);
}
setMenuSetting_BackgroundColor(i)
{
	setMenuSetting("color_background",i);
}
getMenuSetting_Time()
{
	return 0.1;
}

setMenuBackground(i)
{
	setMenuSetting("shader_background",i);
}
setMenuScroller(i)
{
	setMenuSetting("shader_scroller",i);
}
setMenuBarTop(i)
{
	setMenuSetting("shader_barTop",i);
}









