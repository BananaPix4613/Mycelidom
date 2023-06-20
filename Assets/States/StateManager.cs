using Godot;
using System;

public partial class StateManager : Node
{
	[Export]
	public BaseState StartingState { get; set; }

	public BaseState CurrentState { get; set; }

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (CurrentState != null)	
			CurrentState.Exit();
	}	
	
	public void ChangeState(BaseState newState) 
	{
		if (CurrentState != null)
			CurrentState.Exit();

		CurrentState = newState;
		CurrentState.Enter();
	}
	
	public void InitPlayer(Player player)
	{
		foreach(BaseState child in GetChildren()) 
		{
			child.Player = player;
		}
		
		ChangeState(StartingState);
	}
	
	public void Init(Entity entity)
	{
		foreach(BaseState child in GetChildren())
		{
			child.Entity = entity;
		}
		
		ChangeState(StartingState);
	}

    public override void _Input(InputEvent @event)
    {
        CurrentState._Input(@event);
		if (CurrentState.NewState != null)
		{
			ChangeState(CurrentState.NewState);
		}
    }
}
