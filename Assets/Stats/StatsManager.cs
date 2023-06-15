using Godot;
using System;
using System.Collections.Generic;

public partial class StatsManager : Node
{
    List<Node> nodes;
    Player player;
    Entity entity;

    public override void _Ready()
    {
        base._Ready();  
    }

    public void InitPlayer(Player managed) => player = managed;

    public void Init(Entity managed) => entity = managed;

    public void UpdateStat(Stat stat, int value)
    {
        if (nodes.IndexOf(stat) > -1) 
        {
            if (value > 0) 
                ((Stat)nodes.Find(x => x.Name == stat.Name)).CurrentValue = value;
            else
                ((Stat)nodes.Find(x => x.Name == stat.Name)).CurrentValue = 1;
        }
    }

    public void UpdateStatMax(Stat stat, int value)
    {
        if (nodes.IndexOf(stat) > -1) 
        {
            if (value > 0) 
                ((Stat)nodes.Find(x => x.Name == stat.Name)).CurrentValue = value;
            else
                ((Stat)nodes.Find(x => x.Name == stat.Name)).CurrentValue = 1;
        }
    }
}