using Godot;

public partial class Sprint : Move
{
    public override void Enter()
    {
        base.Enter();
        Player.CurrentState(Sprint);
        Player.Animations.SpeedScale = 1.5f;
    }

    public override void Exit()
    {
        base.Exit();
        Player.Animations.SpeedScale = 1;
    }

    public override void _Input(InputEvent @event)
    {
        base._Input(@event);
        if (NewState == null)
        {
            if (Input.IsActionJustReleased("sprint"))
            {
                NewState = Walk;
            }
            NewState = null;
        }
    }
}