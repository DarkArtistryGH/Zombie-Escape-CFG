———————————————————————————————————————————————

   And here is the configs for the entwatch

———————————————————————————————————————————————


"entities"
{
	"0"
	{
		"name"				""			//String, FullName of Item (Chat)
		"shortname"			""			//String, ShortName of Item (Hud)
		"color"				""			//String, One of the colors. (Chat, Glow)
		"buttonclass"			""			//String, Button Class, May matter "game_ui" for Right Click activation method
		"filtername"			""			//String, Filter for Activator
		"blockpickup"			"false"			//Bool, The item cannot be pick up
		"allowtransfer"			"false"			//Bool, Allow admins to transfer an item
		"forcedrop"			"false"			//Bool, Upon death or disconnection of the player, the item will be thrown out
		"chat"				"false"			//Bool, Display chat items
		"hud"				"false"			//Bool, Display Hud items
		"hammerid"			"0"			//Integer, Special weapon HammerID
		"mode"				"0"			//Integer, Mode for Item. 1 = Spam protection only, 2 = Cooldowns, 3 = Limited uses, 4 = Limited uses 
		                                                        with cooldowns, 5 = Cooldowns after multiple uses
		"maxuses"			"0"			//Integer, Maximum uses for modes 3,4,5
		"cooldown"			"0"			//Integer, Cooldown of item for modes 2,4,5
		"buttonid"			"0"			//Integer, NEW! Allows you to set the main button for which the cooldown will be considered. Use HammerID                                                                         of button
		"trigger"			"0"			//Integer, Sets a trigger that a restrict player cannot activate
		"pt_spawner"			""			//String, NEW! Allows admins to spawn items. Can break the gameplay of the game on the map. Indicate                                                                             Point_Template, which spawn the item
	}
}

red - {red} {darkred} {lightred}
blue - {lightblue} {blue} {cyan}
yellow - {yellow} {olive}
green - {green} {lightgreen} {lime}
orange - {orange} {darkorange}
white - {default} {white} 
purple - {purple} {magenta}
pink - {pink}
gray - {silver} {a} {d} {bluegrey} {grey} {gray}
