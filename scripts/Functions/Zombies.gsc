
KillAllZombies()
{
    level.zombie_total = 0;
    for(a=0;a<3;a++)
    {
        enemies = getaiteamarray( level.zombie_team );
    
        if ( isdefined( enemies ) )
        {
            for (i = 0; i < enemies.size; i++) {
                enemy = enemies[ i ];
            
                if ( zm_utility::is_magic_bullet_shield_enabled( enemy ) )
                {
                    enemy util::stop_magic_bullet_shield();
                }
            
                enemy.allowdeath = 1;
                enemy kill( undefined, undefined, undefined, undefined, undefined, 1 );
            }
        }
    
        wait .5;
        corpses = getcorpsearray();
    
        foreach ( corpse in corpses )
        {
            if ( isactorcorpse( corpse ) )
            {
                corpse delete();
            }
        }
    }
    self PrintToLevel("^5All Zombies ^2Eliminated", true);
}

EditRound(newRound)
{
    level zm_game_module::zombie_goto_round(newRound);
    self PrintToLevel("^5Round Set To: ^2"+newRound); 
}

StartZombiePosition() //works fine
{
    self.ZombiePos = isDefined(self.ZombiePos) ? undefined : true;
    if (isDefined(self.ZombiePos))
    {
        self thread SetZombiePosition();
        self PrintToLevel("^5Teleport to Crosshair ^2Enabled");
    } 
    else 
    {
        self PrintToLevel("^5Teleport to Crosshair ^1Disabled");
        self notify("stop_zombiepos");
    }
}
SetZombiePosition()//works fine
{
    self endon("game_ended");
    self endon("stop_zombiepos");

    while(isDefined(self.ZombiePos))
    {
        forward = anglesToForward(self.angles); // convert player angles to forward vector

        foreach (zombo in GetAITeamArray(level.zombie_team)) 
        {
            // teleport zombie 70 units in front of player
            zombo ForceTeleport(self.origin + (forward[0]*70, forward[1]*70, forward[2]*70));
        }
        wait .1;
    }
}

OneHPZombs()
{
    self.oneHPZombs = isDefined(self.oneHPZombs) ? undefined : true;
    if(isDefined(Self.oneHPZombs)){
        self PrintToLevel("^5One HP Zombies ^2Enabled");
    }
    else { 
        self PrintToLevel("^5One HP Zombies ^2Disabled");
    }
    while(isDefined(self.oneHPZombs))
    {
        foreach (zombo in GetAiTeamArray(level.zombie_team))
        {
            if(isDefined(zombo)) zombo.health = 1;
            wait .1;
        }
        wait .1;
    }
}

ZombieModelChanger()
{
    self.zombiemodels = isDefined(self.zombiemodels) ? undefined : true;
    self endon("end_zombie_model","end_game","game_ended");
    while(isDefined(self.zombiemodels))
    {
        foreach (zombie in getaiteamarray(level.zombie_team))
        {
            if(!isDefined(zombie)) return;
            zombie setModel("defaultactor");
            wait .1;
        }
        wait .1;
    }
}