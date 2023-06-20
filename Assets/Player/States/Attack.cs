using Godot;

public partial class Attack : BaseState
{
    [Export]
    BaseState WalkState { get; set; }

    [Export]
    BaseState SprintState { get; set ;}

    [Export]
    BaseState BlockState { get; set; }

    [Export]
    BaseState IdleState { get; set; }

    [Export]
    BaseState RollState { get; set; }
}