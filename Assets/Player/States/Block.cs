using Godot;

public partial class Block : BaseState
{
    [Export]
    BaseState walkState;

    [Export]
    BaseState sprintstate;

    [Export]
    BaseState idleState;

    [Export]
    BaseState attackState;

    [Export]
    BaseState rollState;

    public override void _Input(InputEvent @event)
    {
        base._Input(@event);
        if (NewState != null)
            return;

        if(Input.IsActionJustReleased("sprint"))
        {
            NewState = walkState;
        }
        else
        {
            NewState = null;
        }
    }
}