using Godot;

public partial class Walk : Move
{
    public override void Enter()
    {
        base.Enter();
        Player.CurrentState(Walk);
        Player.Animations.SpeedScale = 1;
    }

    public override void _Input(InputEvent @event)
    {
        base._Input(@event);
        if (NewState == null)
        {
            if (Input.IsActionPressed("sprint"))
                NewState = Sprint;
            else
                NewState = null;
        }
    }
}