ITEM_BOW_TEXT <- EntityGroup[0];
ITEM_BOW_ARROW_PATH_02 <- EntityGroup[1];
ITEM_BOW_MODEL <- EntityGroup[2];
ITEM_BOW_WEAPON <- EntityGroup[3];
ITEM_BOW_BUTTON <- EntityGroup[4];
ITEM_BOW_TRACK <- EntityGroup[5];
ITEM_BOW_ARROW_PATH_01 <- EntityGroup[6];
ITEM_BOW_ARROW_MODEL <- EntityGroup[7];
ITEM_BOW_MEASURE <- EntityGroup[8];
ITEM_BOW_TPOS <- EntityGroup[9];
ITEM_BOW_EW_COUNTER <- EntityGroup[10];

ITEM_BOW_OWNER <- null;
ITEM_BOW_MAX_ARROWS <- 64;
ITEM_BOW_ARROWS <- 20;
ITEM_BOW_TICK <- false;

Hit <- 0;
Dist <- 0;

BOW_TARGET_01 <- null;
BOW_TARGET_02 <- Entities.FindByName(null, "arrow_phys_detect_02");
BOW_TARGET_03 <- Entities.FindByName(null, "temple_mboss_hitbox");
BOW_TARGET_04 <- Entities.FindByName(null, "caves_mboss_hitbox");
BOSS_DAMAGED <- false;

function OnPostSpawn(){TickBowArrow();}

function PickUpBow()
{
    EF(ITEM_BOW_EW_COUNTER, "SetMaxValueNoFire", "" + ITEM_BOW_MAX_ARROWS);
    EF(ITEM_BOW_EW_COUNTER, "SetValue", "" + ITEM_BOW_ARROWS);
    
    if(ITEM_BOW_OWNER == null){ScriptPrintMessageChatAll(" \x02[A BOW HAS BEEN ACQUIRED]");}
    ITEM_BOW_OWNER = activator;
    ITEM_BOW_OWNER.__KeyValueFromString("targetname", "item_bow_"+split(""+ITEM_BOW_OWNER, "player(")[0]);
    EntFireByHandle(ITEM_BOW_MEASURE, "SetMeasureTarget", "item_bow_"+split(""+ITEM_BOW_OWNER, "player(")[0], 0.00, ITEM_BOW_OWNER, null);
    if(!ITEM_BOW_TICK){ITEM_BOW_TICK=true;TickBowValidOwner();}
}

function TickBowArrow()
{
    EntFireByHandle(self, "RunScriptCode", "TickBowArrow();", 1.50, null, null);
    if(TestOnValid(ITEM_BOW_OWNER, 3) && TestValidMoveParent(ITEM_BOW_WEAPON, ITEM_BOW_OWNER, 3))
    {
        ITEM_BOW_TEXT.__KeyValueFromString("message", "ARROWS: "+ITEM_BOW_ARROWS+"/"+ITEM_BOW_MAX_ARROWS);
        EntFireByHandle(ITEM_BOW_TEXT, "Display", "", 0.00, ITEM_BOW_OWNER, null);
    }
}

function TickBowValidOwner()
{
    if(!TestValidMoveParent(ITEM_BOW_WEAPON, ITEM_BOW_OWNER, 3))
    {
        if(ITEM_BOW_OWNER != null && ITEM_BOW_OWNER.IsValid()){ITEM_BOW_OWNER.__KeyValueFromString("targetname", "player");} 
        EntFireByHandle(ITEM_BOW_MEASURE, "SetMeasureTarget", ""+ITEM_BOW_TPOS.GetName(), 0.00, null, null);
        return ITEM_BOW_TICK = false;
    }
    EntFireByHandle(self, "RunScriptCode", "TickBowValidOwner();", 0.02, null, null);
}

function UseBow()
{
    if(TestValidMoveParent(ITEM_BOW_WEAPON, activator, 3))
    {
        if(ITEM_BOW_ARROWS > 0)
        {
            EntFireByHandle(ITEM_BOW_BUTTON, "FireUser1", "", 0.00, ITEM_BOW_OWNER, null);
            BOSS_DAMAGED = false;
            ITEM_BOW_TRACK.SetOrigin(ITEM_BOW_MODEL.GetOrigin());
            ITEM_BOW_TRACK.SetAngles(ITEM_BOW_MODEL.GetAngles().x, ITEM_BOW_MODEL.GetAngles().y, ITEM_BOW_MODEL.GetAngles().z);
            EntFireByHandle(ITEM_BOW_ARROW_MODEL, "Enable", "", 0.00, null, null);
            TraceDir(ITEM_BOW_TRACK.GetOrigin(), ITEM_BOW_TRACK.GetForwardVector(), 8096, null);
            ITEM_BOW_ARROW_PATH_02.SetOrigin(Hit);
            DebugDrawLine(ITEM_BOW_TRACK.GetOrigin(),Hit,255,0,0,false,1.00);
            DebugDrawBox(Hit, Vector(-8, -8, -8), Vector(8, 8, 8), 0, 255, 255, 200, 5.00);
            EntFireByHandle(ITEM_BOW_TRACK, "StartForward", "", 0.02, null, null);
            local npc_target = [];
            local h = null;
            while(null != (h = Entities.FindByClassname(h, "func_physbox_multiplayer")))
            {
                if(h != null && h.IsValid() && h.GetName().find("caves_add_hbox") != null)
                {
                    npc_target.push(h);
                }
            }
            if(npc_target.len() > 0)
            {
                for(local i = 0; i < npc_target.len(); i++)
                {
                    if(npc_target[i] != null && npc_target[i].IsValid() && DistanceCheck3D(ITEM_BOW_ARROW_PATH_02.GetOrigin(), npc_target[i].GetOrigin()) <= 150)
                    {
                        ITEM_BOW_ARROW_PATH_02.SetOrigin(npc_target[i].GetOrigin());
                        EntFireByHandle(npc_target[i], "FireUser4", "", 0.00, null, null);
                    }
                }
            }
            if(BOW_TARGET_03 != null && BOW_TARGET_03.IsValid())
            {
                if(DistanceCheck3D(ITEM_BOW_ARROW_PATH_02.GetOrigin(), BOW_TARGET_03.GetOrigin()) <= 200)
                {
                    ITEM_BOW_ARROW_PATH_02.SetOrigin(BOW_TARGET_03.GetOrigin());
                    BOSS_DAMAGED = true;
                }
            }
            if(BOW_TARGET_04 != null && BOW_TARGET_04.IsValid())
            {
                if(DistanceCheck3D(ITEM_BOW_ARROW_PATH_02.GetOrigin(), BOW_TARGET_04.GetOrigin()) <= 100)
                {
                    ITEM_BOW_ARROW_PATH_02.SetOrigin(BOW_TARGET_04.GetOrigin());
                    BOSS_DAMAGED = true;
                }
            }
            ITEM_BOW_ARROWS--;
            EF(ITEM_BOW_EW_COUNTER, "SetValue", "" + ITEM_BOW_ARROWS);
        }
    }
}

function ArrowPass()
{
    EntFireByHandle(ITEM_BOW_ARROW_MODEL, "Disable", "", 0.00, null, null);
    BOW_TARGET_01 = Entities.FindByName(null, "arrow_phys_detect");
    if(BOW_TARGET_01 != null && BOW_TARGET_01.IsValid())
    {
        if(DistanceCheck3D(ITEM_BOW_ARROW_PATH_02.GetOrigin(), BOW_TARGET_01.GetOrigin()) <= 40){EntFireByHandle(BOW_TARGET_01, "FireUser1", "", 0.00, null, null);}
    }
    if(BOW_TARGET_02 != null && BOW_TARGET_02.IsValid())
    {
        if(DistanceCheck3D(ITEM_BOW_ARROW_PATH_02.GetOrigin(), BOW_TARGET_02.GetOrigin()) <= 40){EntFireByHandle(BOW_TARGET_02, "FireUser1", "", 0.00, null, null);}
    }
    if(BOW_TARGET_03 != null && BOW_TARGET_03.IsValid())
    {
        if(BOSS_DAMAGED){EntFireByHandle(BOW_TARGET_03, "FireUser2", "", 0.00, null, null);}
    }
    if(BOW_TARGET_04 != null && BOW_TARGET_04.IsValid())
    {
        if(BOSS_DAMAGED)
        {
            BOW_TARGET_04.GetScriptScope().ChangeHealthIt(150);
            // EntFireByHandle(BOW_TARGET_04, "FireUser4", "", 0.00, null, null);
        }
    }
    EntFireByHandle(ITEM_BOW_TRACK, "TeleportToPathNode", ""+ITEM_BOW_ARROW_PATH_01.GetName(), 0.00, null, null);
}

function TestValidAct(owner, act, team)
{
    if(act == owner && owner.GetTeam() == team){return true;}
    else{return false;}
}

function TestOnValid(handle, team)
{
    if(handle != null && handle.IsValid() && handle.GetTeam() == team && handle.GetHealth() > 0){return true;}
    return false;
}

function TestValidMoveParent(handle_move, owner, team)
{
    try
    {
        if(handle_move.GetMoveParent() != null && handle_move.GetMoveParent() == owner && owner.GetTeam() == team){return true;}
        else{return false;}
    }
    catch(error){return false;}
}

function TraceDir(orig, dir, maxd, filter)
{
	local frac = TraceLine(orig,orig+dir*maxd,filter);
	if(frac == 1.0) 
    {
        local S_Hit = orig + dir * maxd;
        local S_Dist = 0.00;
        return Hit = S_Hit, Dist = S_Dist;
    }
    local S_Hit = orig + (dir * (maxd * frac));
    local S_Dist = maxd * frac;
	return Hit = S_Hit, Dist = S_Dist;
}

function DistanceCheck3D(obj, obj_2)
{
    local dist = (obj.x-obj_2.x)*(obj.x-obj_2.x)+(obj.y-obj_2.y)*(obj.y-obj_2.y)+(obj.z-obj_2.z)*(obj.z-obj_2.z);
    return sqrt(dist).tointeger();
}

function AddArrows(n)
{
    if(ITEM_BOW_ARROWS < ITEM_BOW_MAX_ARROWS)
    {
        ITEM_BOW_ARROWS += n;
        if(ITEM_BOW_ARROWS > ITEM_BOW_MAX_ARROWS){ITEM_BOW_ARROWS = ITEM_BOW_MAX_ARROWS;}

        EF(ITEM_BOW_EW_COUNTER, "SetValue", "" + ITEM_BOW_ARROWS);
    }
}

// // // // // // // //
// KOTYA SHIT STAFF  //
// // // // // // // //

::EF <- function(item, key, value = "", d = 0)
{
	if (typeof item == "string")
	{
		EntFire(item, key, value, d);
	}
	else if (typeof item == "instance")
	{
		EntFireByHandle(item, key, value, d, item, item);
	}
}
