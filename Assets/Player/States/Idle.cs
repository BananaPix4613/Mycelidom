using Godot;

public partial class Idle : BaseState
{
    [Export]
    BaseState walkState;

    [Export]
    BaseState sprintState;

    [Export]
    BaseState blockState;

    [Export]
    BaseState attackState;

    [Export]
    BaseState rollState;

    [Export]
    BaseState idleState;

    public override void Enter()
    {
        base.Enter();
        Player.CurrentState(idleState);
        Player.Velocity = Vector2.Zero;
    }

    public override void _Input(InputEvent @event)
    {
        if (Input.IsActionJustPressed("move_left") 
            || Input.IsActionJustPressed("move_right")
            || Input.IsActionJustPressed("move_up")
            || Input.IsActionJustPressed("move_down"))
        {
            if (Input.IsActionPressed("sprint"))
                NewState = sprintState;
            else
                NewState = walkState;
        }       
    }

    public override void _PhysicsProcess(double delta)
    {
        Player.MoveAndSlide();
    }
}