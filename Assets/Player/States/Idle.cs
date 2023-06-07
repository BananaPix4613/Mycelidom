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

    public override void Enter()
    {
        base.Enter();
    }
}