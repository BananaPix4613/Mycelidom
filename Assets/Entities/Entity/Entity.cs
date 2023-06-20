using System;
using Godot;

public partial class Entity : CharacterBody2D
{
	[Signal]
    public delegate void UpdateStateEventHandler();

	[Signal]
	public delegate void UpdateHealthEventHandler();

	[Signal]
	public delegate void UpdateEnergyEventHandler();

	[Export]
	public AnimationPlayer Animations { get; set; }
	
	[Export]
	public StateManager States { get; set; }

	[Export]
	public StatsManager Stats { get; set; }

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		States.Init(this);
		Stats.Init(this);
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		States._Process(delta);
	}

    public override void _PhysicsProcess(double delta)
    {
        States._PhysicsProcess(delta);
    }

	public void CurrentState(BaseState state)
	{
		EmitSignal("UpdateState", state);
	}

    public override void _UnhandledInput(InputEvent @event)
    {
        States._Input(@event);
    }
}
