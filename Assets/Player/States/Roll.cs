using System;
using Godot;

public partial class Roll : Move
{
    [Export]
    double rollTime = 0.4;

    [Export]
    double cooldown = 1;

    [Export]
    public Timer RollCooldown { get; set; }

    double currentRollTime = 0;
    Vector2 rollDirection;

    public override void Enter()
    {
        base.Enter();
        Player.CurrentState(Roll);
        RollCooldown.WaitTime = cooldown;
        currentRollTime = rollTime;
        // Might use C# List instead of array
        // rollDirection = GetDirectionFromInt(directions.FindIndexOf(x => x == Player.Animations.CurrentAnimation) + 1);
        IsRolling = true;
    }

    public override void Exit()
    {
        base.Exit();
        RollCooldown.Start();
        IsRolling = false;
    }

    public override Vector2 GetMovementInput() => rollDirection != null ? rollDirection : Vector2.Zero;

    public override void _Process(double delta)
    {
        currentRollTime -= delta;

        if (Input.IsActionPressed("move_left")
            || Input.IsActionPressed("move_right")
            || Input.IsActionPressed("move_up")
            || Input.IsActionPressed("move_down"))
        {
            if (Input.IsActionPressed("sprint"))
            {
                NewState = Sprint;
            }
            else
            {
                NewState = Walk;
            }
        }
        else
            NewState = Idle;
    }

    public Vector2 GetDirectionFromInt(int number) => number switch
    {
        1 => new Vector2(1, 0),
        2 => new Vector2(1, 1),
        3 => new Vector2(0, 1),
        4 => new Vector2(-1, 1),
        5 => new Vector2(-1, 0),
        6 => new Vector2(-1, 1),
        7 => new Vector2(0, -1),
        8 => new Vector2(1, -1),
        _ => Vector2.Down
    };
}