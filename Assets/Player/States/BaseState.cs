using Godot;
using System;

public partial class BaseState : Node 
{
    public Player Player { get; set; }
    public Entity Entity { get; set; }
    public BaseState NewState { get; set; }

    public virtual void Enter() {}
    public virtual void Exit() {}
}