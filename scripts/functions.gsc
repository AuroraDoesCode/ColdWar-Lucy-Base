


PrintLevelType()
{
#ifdef MP 
    self iPrintLn("We're in Multiplayer!");
#endif

#ifdef ZM
    self iPrintLn("We're in Zombies!");
#endif
}